import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/catagory_models.dart';
import '../models/product_model.dart';

class ApiService {
  static const String url = 'http://10.0.2.2/pifast_Api/fetch_products.php';

  // ক্যাটাগরি ফেচ করার ফাংশন   New Add
  static Future<List<CategoryModel>> fetchCategories() async {
    const String categoryUrl = 'http://10.0.2.2/pifast_Api/fetch_categories.php';
    final response = await http.get(Uri.parse(categoryUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => CategoryModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // ক্যাটাগরি অনুযায়ী প্রোডাক্ট ফেচ // New Add
  static Future<List<ProductModel>> fetchProductsByCategory(String tableName) async {
    const String baseUrl = 'http://10.0.2.2/pifast_Api/fetch_products_by_category.php';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {'table_name': tableName},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => ProductModel.fromMap(item)).toList();
    } else {
      throw Exception('Failed to fetch products by category');
    }
  }
}

