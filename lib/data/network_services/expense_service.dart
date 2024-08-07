import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/data/repositories/expense_repo.dart';
import 'package:finance_app/model/expense_models.dart';

class ExpenseService {
  Future<ExpenseModel?> fetchExpenses(String token) async {
    try {
      final response = await ExpenseRepository.fetchExpenses(token);
      return response;
    } catch (e) {
      print('Service error: $e');
      return null;
    }
  }


  static Future<Object> addExpense(AddExpense expense, String token) async {
    try {
      final response = await ExpenseRepository.addExpense(token, expense);
      if (response is Success) {
        return response;
      }
      else {
        print('failed to add expense');
        return Failure(response: "Failed to add incoe");
      }

    }
    catch(e) {
      return Failure(code: 500, response: "Invalid Response");
    }
    
  }
  

  // code to delete expense
  static Future<Object> deleteExpense(String token, int id) async {
    try {
      final response = await ExpenseRepository.deleteExpense(token, id);
      if (response is Success) {
        return response;
      }
      else {
        print('failed to delete expense');
        return Failure(response: "Failed to delete expense");
      }

    }
    catch(e) {
      return Failure(code: 500, response: "Invalid Response");
    }
  }

  // code to update expense
  static Future<Object> updateExpense(String token, int id) async {
    try {
      final response = await ExpenseRepository.updateExpense(token, id);
      if (response is Success) {
        return response;
      }
      else {
        print('failed to update expense');
        return Failure(response: "Failed to update expense");
      }

    }
    catch(e) {
      return Failure(code: 500, response: "Invalid Response");
    }
  }
  

}


