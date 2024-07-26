import 'package:finance_app/app_services/network_handler.dart';
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
    // if(token != null) {
    //   var response = await _ExpenseService.fetchExpenses(token);
    //   if(response != null) {
    //     _expenseModel = response;
    //     // _errorMessage = '';
    //   } 
    // } 

    if (token != null) {
      var response = await _ExpenseService.fetchExpenses(token);
      if (response != null) {
        _expenseModel = response;
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to fetch expenses, check connection';
      }
    } else {
      _errorMessage = 'Token not found';
    }
    notifyListeners();
  }

  // cde to add new expense
  String _newExpenseDetails = '';
  String get newExpenseDetails => _newExpenseDetails;
  void setNewExpenseDetails(String value) {
    _newExpenseDetails = value;
    notifyListeners();
  }

  Future<void> addExpense(AddExpense expense, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null){
      var response = await ExpenseService.addExpense(expense, token);
      if(response is Success){
        setNewExpenseDetails(expense.toJson().toString());
        print(response.response);
        notifyListeners();
      }
      else if (response is Failure){
        print(response.code);

      }
    }

}
}
