import 'dart:convert';
import 'package:finance_app/app_services/network_handler.dart';
import 'package:http/http.dart' as http;
import 'package:finance_app/app_services/app_url.dart';
import 'package:finance_app/model/data.dart';

class UserRepository {
  static Future<AuthenticatedUser?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrl.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        AuthenticatedUser user = AuthenticatedUser.fromJson(decodedResponse);
        return user;
      } else {
        print('Login failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  // code for adding user

  static Future<Object> addUser(AddUser user) async {
      try {
        var url = Uri.parse(AppUrl.register);
        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user.toJson()),
        );
        
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
        if (response.statusCode == 201) {
          return Success(code: 201, response: "User added successfully ", );
        } else {
          return Failure(
              code: response.statusCode, response: "Failed to add user");
        }
  //       if (response.statusCode == 201) {

    } catch (e) {
      return Failure(response: "Invalid Response");
    }
  
  }
  
}

