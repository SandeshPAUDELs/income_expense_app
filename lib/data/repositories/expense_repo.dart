import 'dart:convert';

import 'package:finance_app/app_services/app_url.dart';
import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/model/expense_models.dart';
import 'package:http/http.dart' as http;

class ExpenseRepository {
  static Future<ExpenseModel?> fetchExpenses(String token) async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.expenses),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        return ExpenseModel.fromJson(decodedResponse);
      } else {
        print('Failed to fetch expenses with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during fetching expenses: $e');
      return null;
    }
  }

  // code to add new expense
  static Future<Object> addExpense(String token, AddExpense expense) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrl.expenses),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(expense.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // return true;
        return Success(code: 201, response: "Expense Added Successfully");
      } else {
        print('Failed to add expense with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during adding expense: $e');
      return false;
    }
  }

  // code to delete expense
  static Future<Object> deleteExpense(String token, int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppUrl.expenses}$id/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 204) {
        return Success(code: 204, response: "Expense Deleted Successfully");
      } else {
        print('Failed to delete expense with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during deleting expense: $e');
      return false;
    }
  }
}
