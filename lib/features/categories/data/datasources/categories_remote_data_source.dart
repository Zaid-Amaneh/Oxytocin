import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oxytocin/core/Utils/services/url_container.dart';
import '../models/category_model.dart';

class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('${UrlContainer.baseUrl}doctors/specialties/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في تحميل الفئات');
    }
  }
}
