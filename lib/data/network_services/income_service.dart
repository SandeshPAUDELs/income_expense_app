import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/data/repositories/income_repo.dart';
import 'package:finance_app/model/income_models.dart';

class IncomeService {
  Future<IncomeModel?> fetchIncomes(String token) async {
    try {
      final response = await IncomeRepository.fetchIncomes(token);
      return response;
    } catch (e) {
      print('Service error: $e');
      return null;
    }
  }

  // code to add Incomes
  static Future<Object> addIncome(AddIncome income, String token) async {
    try {
      final response = await IncomeRepository.addIncome(income, token);
      if (response is Success) {
        return response;
      }
      else {
        print('failed to add income');
        return Failure(response: "Failed to add incoe");
      }

    }
    catch(e) {
      return Failure(code: 500, response: "Invalid Response");
    }
    
  }
  // code to delete income
  static Future<Object> deleteIncome(String token, int id) async {
    try {
      final response = await IncomeRepository.deleteIncome(token, id);
      if (response is Success) {
        return response;
      }
      else {
        print('failed to delete income');
        return Failure(response: "Failed to delete income");
      }

    }
    catch(e) {
      return Failure(code: 500, response: "Invalid Response");
    }
  }
}