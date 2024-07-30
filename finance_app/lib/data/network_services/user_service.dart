import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/data/repositories/user_repo.dart';
import 'package:finance_app/model/data.dart';

class UserService {
  Future<AuthenticatedUser?> login(String username, String password) async {
    try {
      final response = await UserRepository.login(username, password);
      return response;
    } catch (e) {
      print('Service error: $e');
      return null;
    }
  }

  // code for adding user
  static Future<Object> addUser(AddUser user) async {
    try {
      final response = await UserRepository.addUser(user);
      if (response is Success) {
        return response;
      } else {
        print('Failed to add user');
        return Failure(response: "Failed to add user");
      }
    } catch (e) {
      return Failure(code: 500, response: "Invalid Response");
    }
  }
}

