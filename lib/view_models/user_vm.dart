import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/data/network_services/user_service.dart';
import 'package:finance_app/model/data.dart';
import 'package:finance_app/styles/snackbar.dart';
import 'package:finance_app/view/home_screen.dart';
import 'package:finance_app/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final UserService _authService = UserService();
  AuthenticatedUser? _authenticatedUser;
  AuthenticatedUser? get authenticatedUser => _authenticatedUser;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  String _successMessage = '';
  String get successMessage => _successMessage;

  Future<void> login(
      String username, String password, BuildContext context) async {
    var response = await _authService.login(username, password);
    if (response != null) {
      _authenticatedUser = response;
      print('Authenticated user token: ${_authenticatedUser!.token}');

      // Store token in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _authenticatedUser!.token);

      _successMessage = 'YOu are logged in ';

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      SnackBarTheme.showSnackBar(context, _successMessage);
    } else {
      _errorMessage = 'Invalid Credentials';
      SnackBarTheme.showSnackBar(context, _errorMessage);
    }
    notifyListeners();
  }

  // code for adding user
  String _newUserDetails = '';
  String get newUserDetails => _newUserDetails;
  void setNewUserDetails(String value) {
    _newUserDetails = value;
    notifyListeners();
  }

  Future<void> addUser(AddUser user, BuildContext context) async {
    var finalResponse = await UserService.addUser(user);
    if (finalResponse is Success) {
      setNewUserDetails(user.toJson().toString());
      _successMessage = "User Added Successfully";
      SnackBarTheme.showSnackBar(context, _successMessage);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );

      // print(finalResponse.response);
      notifyListeners();
    } else if (finalResponse is Failure) {
      _errorMessage = "Failed to Add User";
      SnackBarTheme.showSnackBar(context, _errorMessage);

      // print(finalResponse.code);
    }
  }
}
