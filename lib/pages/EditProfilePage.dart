import 'package:flutter/material.dart';
import '../data_api/push_profile_api.dart'; // Import the API service

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Create an instance of ApiService
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Method to load user profile data from API
  Future<void> _loadUserProfile() async {
    final userProfile = await apiService.fetchUserProfile();
    if (userProfile.isNotEmpty) {
      _nameController.text = userProfile['name'];
      _emailController.text = userProfile['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text;
                String email = _emailController.text;

                // Update profile data using the API service
                bool success = await apiService.updateUserProfile(name, email);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
