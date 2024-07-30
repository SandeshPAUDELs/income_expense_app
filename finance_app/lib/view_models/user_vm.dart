import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/data/network_services/user_service.dart';
import 'package:finance_app/model/data.dart';
import 'package:finance_app/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
    String _newUserDetails = '';
  String get newUserDetails => _newUserDetails;
  void setNewUserDetails(String value) {
    _newUserDetails = value;
    notifyListeners();
  }

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
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _errorMessage = 'Invalid Credentials';
      print('Error: $_errorMessage');
    }
    notifyListeners();
  }
  
  // code for adding user
  Future<void> addUser(AddUser user) async {
    var finalResponse = await UserService.addUser(user);
    if (finalResponse is Success) {
      setNewUserDetails(user.toJson().toString());
      print(finalResponse.response); 
      notifyListeners();
    } else if (finalResponse is Failure) {
      print(finalResponse.code);
      
    }
  }
}
