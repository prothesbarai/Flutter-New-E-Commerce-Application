import 'package:flutter/material.dart';
import '../data_api/push_profile_api.dart'; // Your API service
import '../profile_database_helper.dart';       // Your local SQLite helper

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    // Try local first
    final localData = await DatabaseHelper.instance.getUserProfile();
    if (localData != null) {
      _nameController.text = localData['name'];
      _emailController.text = localData['email'];
    }

    // Then try online (optional)
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

                // First try online update
                bool success = await apiService.updateUserProfile(name, email);

                if (success) {
                  // Save to local DB too
                  await DatabaseHelper.instance.saveUserProfile(name, email);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile Updated')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update profile')),
                  );
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
