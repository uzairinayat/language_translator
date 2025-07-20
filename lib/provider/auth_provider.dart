import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _userEmail;

  String? get userEmail => _userEmail;

  Future<bool> signup(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_signup_email', email);
    await prefs.setString('saved_signup_password', password);
    _userEmail = email;
    notifyListeners();
    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_signup_email');
    final savedPassword = prefs.getString('saved_signup_password');

    if (savedEmail == email && savedPassword == password) {
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> resetPassword(String email) async {
  final prefs = await SharedPreferences.getInstance();
  final savedEmail = prefs.getString('saved_signup_email');

  if (savedEmail == email) {
    return true; 
  }
  return false;
  }

  void logout() {
    _userEmail = null;
    notifyListeners();
  }
}
