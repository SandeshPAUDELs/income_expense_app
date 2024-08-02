import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/model/income_models.dart';
import 'package:finance_app/styles/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/data/network_services/income_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeViewModel extends ChangeNotifier {
  final IncomeService _incomeService = IncomeService();
  IncomeModel? _incomeModel;
  IncomeModel? get incomeModel => _incomeModel;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  String _successMessage = '';
  String get successMessage => _successMessage;

  Future<void> fetchIncomes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      var response = await _incomeService.fetchIncomes(token);
      if (response != null) {
        _incomeModel = response;
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to fetch incomes/ check connectin';
      }
    } else {
      _errorMessage = 'Token not found';
    }
    notifyListeners();
  }

// code to add new incomes

  String _newIncomeDetails = '';
  String get newIncomeDetails => _newIncomeDetails;
  void setNewIncomeDetails(String value) {
    _newIncomeDetails = value;
    notifyListeners();
  }

  Future<void> addIncome(
      AddIncome income, String token, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      var response = await IncomeService.addIncome(income, token);
      if (response is Success) {
        setNewIncomeDetails(income.toJson().toString());
        // print(response.response);
        _successMessage = "Income addded Successfully";
        SnackBarTheme.showSnackBar(context, _successMessage);
        notifyListeners();
      } else if (response is Failure) {
        _errorMessage = "Failed to Add Income";
        SnackBarTheme.showSnackBar(context, _errorMessage);
        // print(response.code);
      }
    }
  }

// code to delete income
  Future<void> deleteIncome(int id, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      var response = await IncomeService.deleteIncome(token, id);
      if (response is Success) {
        _successMessage = "Income Deleted Successfullly";
        SnackBarTheme.showSnackBar(context, _successMessage);
        // print(response.response);
        notifyListeners();
      } else if (response is Failure) {
        _errorMessage = "Failed to Delete Incomes";
        SnackBarTheme.showSnackBar(context, _errorMessage);
        // print(response.code);
      }
    }
  }
}
