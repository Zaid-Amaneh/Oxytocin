import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/categories/data/models/doctors_response.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_model.dart'
    show DoctorModel;
import '../models/category_model.dart';

class CategoriesRemoteDataSource {
  final http.Client client = http.Client();
  final SecureStorageService secureStorageService = SecureStorageService();

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('${UrlContainer.baseUrl}doctors/specialties/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في تحميل الفئات');
    }
  }

  // في CategoriesRemoteDataSource
  Future<DoctorsResponse> fetchDoctorsBySubspecialty(int subspecialtyId) async {
    final response = await client.get(
      Uri.parse('${UrlContainer.baseUrl}doctors/search/').replace(
        queryParameters: {
          'sub_specialties': subspecialtyId.toString(),
          'page_size': '20',
        },
      ),
      headers: {
        // 'Authorization': 'Bearer ${secureStorageService.getToken()}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DoctorsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load doctors by subspecialty');
    }
  }
  // Future<List<DoctorModel>> fetchDoctorsBySpecialty(int specialtyId) async {
  //   final uri = Uri.parse(
  //     '${UrlContainer.baseUrl}doctors/search/?specialties=$specialtyId',
  //   );

  //   final headers = {'Accept': 'application/json'};

  //   final response = await client.get(uri, headers: headers);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final List doctorsJson = data['results'];
  //     return doctorsJson.map((e) => DoctorModel.fromJson(e)).toList();
  //   } else {
  //     throw Exception("فشل في جلب الأطباء");
  //   }
  // }
}
