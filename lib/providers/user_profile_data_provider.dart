import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';

  String get name => _name;
  String get email => _email;

  void setUser(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners(); // Triggers all listening widgets (like Drawer)
  }

  void loadFromMap(Map<String, dynamic> data) {
    _name = data['name'] ?? '';
    _email = data['email'] ?? '';
    notifyListeners();
  }
}
