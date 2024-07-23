import 'package:finance_app/data/network_services/user_service.dart';
import 'package:finance_app/main.dart';
import 'package:finance_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final UserService _authService = UserService();
  AuthenticatedUser? _authenticatedUser;
  AuthenticatedUser? get authenticatedUser => _authenticatedUser;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> login(String username, String password, BuildContext context) async {
    var response = await _authService.login(username, password);
    if (response != null) {
      _authenticatedUser = response;
      print('Authenticated user token: ${_authenticatedUser!.token}');

      // Store token in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _authenticatedUser!.token);

      _errorMessage = '';

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Placeholder()),
      );
    } else {
      _errorMessage = 'Invalid Credentials';
      print('Error: $_errorMessage');
    }
    notifyListeners();
  }
}
