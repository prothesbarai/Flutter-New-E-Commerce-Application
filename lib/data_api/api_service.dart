import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String url = 'http://10.0.2.2/pifast_Api/fetch_products.php';

  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => ProductModel.fromMap(item)).toList();
    } else {
      throw Exception('ডেটা আনতে সমস্যা হয়েছে');
    }
  }
}

