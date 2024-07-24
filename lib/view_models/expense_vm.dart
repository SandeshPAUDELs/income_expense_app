import 'package:finance_app/data/network_services/expense_service.dart';
import 'package:finance_app/model/expense_models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseService _ExpenseService = ExpenseService();
  ExpenseModel? _expenseModel;
  ExpenseModel? get expenseModel => _expenseModel;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      var response = await _ExpenseService.fetchExpenses(token);
      if (response != null) {
        _expenseModel = response;
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to fetch expenses';
      }
    } else {
      _errorMessage = 'Token not found';
    }
    notifyListeners();
  }
}
