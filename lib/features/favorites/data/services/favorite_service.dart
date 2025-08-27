import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/url_container.dart';
import '../models/favorite_response.dart';
import '../models/doctor_model.dart';

class FavoriteService {
  Future<List<FavoriteDoctor>> getFavorites(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${UrlContainer.domainUrl}/api/patients/favorites/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final favoriteResponse = FavoriteResponse.fromJson(jsonData);

        final doctorsMap = <int, Doctor>{};
        for (final fav in favoriteResponse.results) {
          doctorsMap[fav.doctor.id] = fav.doctor;
        }

        final doctors = doctorsMap.values.toList();

        return favoriteResponse.results;
      } else {
        throw Exception('فشل في الحصول على المفضلة: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  Future<List<Doctor>> getFavoriteDoctors(String token) async {
    try {
      final favoriteDoctors = await getFavorites(token);
      return favoriteDoctors.map((fav) => fav.doctor).toList();
    } catch (e) {
      throw Exception('فشل في الحصول على أطباء المفضلة: $e');
    }
  }

  Future<void> addFavorite(String token, int doctorId) async {
    try {
      final response = await http.post(
        Uri.parse('${UrlContainer.domainUrl}/api/patients/favorites/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'doctor_id': doctorId}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('فشل في إضافة الطبيب للمفضلة: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  Future<void> removeFavorite(String token, int favoriteId) async {
    try {
      final response = await http.delete(
        Uri.parse(
          '${UrlContainer.domainUrl}/api/patients/favorites/$favoriteId/',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 204) {
        throw Exception('فشل في حذف الطبيب من المفضلة: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  Future<int?> getFavoriteId(String token, int doctorId) async {
    try {
      final response = await http.get(
        Uri.parse('${UrlContainer.domainUrl}/api/patients/favorites/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final favoriteResponse = FavoriteResponse.fromJson(jsonData);

        for (final favorite in favoriteResponse.results) {
          if (favorite.doctor.id == doctorId) {
            return favorite.id;
          }
        }
      } else {}
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isDoctorFavorite(String token, int doctorId) async {
    try {
      final favorites = await getFavorites(token);
      return favorites.any((doctor) => doctor.id == doctorId);
    } catch (e) {
      return false;
    }
  }

  Future<void> cleanDuplicateFavorites(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${UrlContainer.domainUrl}/api/patients/favorites/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final favoriteResponse = FavoriteResponse.fromJson(jsonData);
        final doctorIds = <int>{};
        final duplicatesToRemove = <int>[];

        for (final favorite in favoriteResponse.results) {
          if (doctorIds.contains(favorite.doctor.id)) {
            duplicatesToRemove.add(favorite.id);
          } else {
            doctorIds.add(favorite.doctor.id);
          }
        }
        for (final duplicateId in duplicatesToRemove) {
          try {
            await removeFavorite(token, duplicateId);
          } catch (e) {}
        }
      }
    } catch (e) {}
  }
}
