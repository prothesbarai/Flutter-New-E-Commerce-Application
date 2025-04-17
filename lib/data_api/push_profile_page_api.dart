import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2/pifast_Api/';

  Future<bool> updateUserProfile(String name, String email, String city, String shipping, String billing) async {
    try {
      final url = Uri.parse('$baseUrl/update_profile_info.php');
      final response = await http.post(url, body: {
        'name': name,
        'email': email,
        'city': city,
        'shipping_address': shipping,
        'billing_address': billing,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['status'] == 'success';
      } else {
        print('Server error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      final url = Uri.parse('$baseUrl/get_profile.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to load profile');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }
}