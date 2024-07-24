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
}
