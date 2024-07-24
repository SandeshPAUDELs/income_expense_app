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
}


