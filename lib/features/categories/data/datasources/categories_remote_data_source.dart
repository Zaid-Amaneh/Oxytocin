import 'package:http/http.dart' as http;
import 'package:oxytocin/core/Utils/services/secure_storage_service.dart';
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart';
import 'package:oxytocin/features/categories/data/models/doctors_response.dart';
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

  Future<DoctorsResponse> fetchDoctorsBySpecialty(int specialtyId) async {
    final uri = Uri.parse(
      '${UrlContainer.baseUrl}doctors/search/?specialties=$specialtyId',
    );

    final headers = {'Accept': 'application/json'};

    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return DoctorsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("فشل في جلب الأطباء");
    }
  }
}
