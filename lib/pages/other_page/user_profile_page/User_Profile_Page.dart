import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data_api/push_profile_page_api.dart'; // Your API service
import '../../../helper/profile_page_database_helper.dart';
import '../../../providers/user_profile_data_provider.dart'; // Your local SQLite helper

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _shippingaddressController = TextEditingController();
  final TextEditingController _billingaddressController = TextEditingController();

  final ApiService apiService = ApiService();
  bool _fromSaved = false; // ✅ Flag to avoid online overwrite after saving

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
      _cityController.text = localData['city'];
      _shippingaddressController.text = localData['shipping_address'];
      _billingaddressController.text = localData['billing_address'];
    }

    // Then try online (optional)
    // ✅ Prevent online fetch after save to avoid overwriting recent update
    if (!_fromSaved) {
      final userProfile = await apiService.fetchUserProfile();
      if (userProfile.isNotEmpty) {
        _nameController.text = userProfile['name'];
        _emailController.text = userProfile['email'];
        _cityController.text = userProfile['city'];
        _shippingaddressController.text = userProfile['shipping_address'];
        _billingaddressController.text = userProfile['billing_address'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile',style: TextStyle(color: AppColor.pink1),),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.pink1),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_nameController, "Name", Icons.person),
              _buildTextField(_emailController, "Email", Icons.email),
              _buildTextField(_cityController, "City", Icons.location_city),
              _buildTextField(_shippingaddressController, "Shipping Address", Icons.local_shipping),
              _buildTextField(_billingaddressController, "Billing Address", Icons.place),
              SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _saveProfile,
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }


  // ================== User Input Field Design Here ========================
  Widget _buildTextField(TextEditingController controller, String lebel, IconData icon){
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: lebel,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
    );
  }

  // ================== User Profile Data Saved Button =========================
  Future<void> _saveProfile() async{
    String name = _nameController.text;
    String email = _emailController.text;
    String city = _cityController.text;
    String shipping_address = _shippingaddressController.text;
    String billing_address = _billingaddressController.text;

    // First try online update
    bool success = await apiService.updateUserProfile(name, email, city, shipping_address, billing_address);
    if (success) {
      // Save to local DB too
      await DatabaseHelper.instance.saveUserProfile(name, email, city, shipping_address, billing_address);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Updated')),
      );
      // 🔥 Update Provider Send Data To Drawer in App
      Provider.of<UserProfileProvider>(context, listen: false).setUser(name, email);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }

  }
}
