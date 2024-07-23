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
}

