import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:finance_app/app_services/app_url.dart';
import 'package:finance_app/app_services/network_handler.dart';
import 'package:finance_app/model/income_models.dart';

class IncomeRepository {
  static Future<Object> fetchIncomeData(String apiName) async {
    try {
      var url = Uri.parse(AppUrl.domain + apiName);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) {
          List<IncomeModel> incomeList =
              decodedResponse.map((item) => IncomeModel.fromJson(item)).toList();
          return Success(code: 200, response: incomeList);
        } else if (decodedResponse is Map<String, dynamic>) {
          IncomeModel incomeModel = IncomeModel.fromJson(decodedResponse);
          return Success(code: 200, response: [incomeModel]);
        } else {
          return Failure(
              code: response.statusCode,
              response: "Invalid Response Structure");
        }
      } else {
        return Failure(
            code: response.statusCode, response: "Invalid Response Coming");
      }
    } catch (e) {
      return "Invalid Response";
    }
  }
}