import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Define the base URL (adjust this depending on your server setup)
  static const String baseUrl = 'http://10.0.2.2/pifast_Api/';// Update this URL for your local server

  // Method to update user profile
  Future<bool> updateUserProfile(String name, String email) async {
    try {
      // The API endpoint to save/update user profile
      final url = Uri.parse('$baseUrl/update_profile_info.php');

      // Prepare the data to send in the request body
      final response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
        },
      );

      // Check if the API request was successful
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // If the API returns a success message, return true
        return responseData['status'] == 'success';
      } else {
        // Handle failed request
        print('Failed to update profile');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Method to fetch user profile (if needed)
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
