import 'dart:convert';
import 'package:finance_app/app_services/app_url.dart';
import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/model/income_models.dart';
import 'package:http/http.dart' as http;

class IncomeRepository {
  static Future<IncomeModel?> fetchIncomes(String token) async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.incomes),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        return IncomeModel.fromJson(decodedResponse);
      } else {
        print('Failed to fetch incomes with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during fetching incomes: $e');
      return null;
    }
  }

  //  code to add income
  static Future<Object> addIncome(AddIncome income, String token) async {
    try {
      var url = Uri.parse(AppUrl.incomes);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        },
        body: jsonEncode(income.toJson()),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        return Success(code: 201, response: "Income Added Successfully");
      } else {
        return Failure(
            code: response.statusCode, response: "Failed to Add Income");
      }
    } catch (e) {
      return Failure(response: "Invalid Response");
    }
  }

  // code to delete income
  static Future<Object> deleteIncome(String token, int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppUrl.incomes}$id/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 204) {
        return Success(code: 204, response: "Income Deleted Successfully");
      } else {
        print('Failed to delete income with status: ${response.statusCode}');
        return Failure(
            code: response.statusCode, response: "Failed to delete income");
      }
    } catch (e) {
      print('Error during deleting income: $e');
      return Failure(response: "Invalid Response");
    }
  }
}
