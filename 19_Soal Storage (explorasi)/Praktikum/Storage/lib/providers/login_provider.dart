import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  String username = "";
  String email = "";

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      username = prefs.getString('username') ?? "";
      email = prefs.getString('email') ?? "";
    }
    notifyListeners();
  }

  Future<bool> login(String username, String email, String password) async {
    if (username == 'AgentGalon' &&
        email == 'agentgalon@gmail.com' &&
        password == 'passwordnya123') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      await prefs.setString('email', email);

      updateUserData(username, email);

      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn = false;
    username = "";
    email = "";
    notifyListeners();
  }

  void updateUserData(String newUsername, String newEmail) {
    username = newUsername;
    email = newEmail;
    notifyListeners();
  }
}
