import 'package:finance_app/model/income_models.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/data/network_services/income_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeViewModel extends ChangeNotifier {
  final IncomeService _incomeService = IncomeService();
  IncomeModel? _incomeModel;
  IncomeModel? get incomeModel => _incomeModel;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

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
}
