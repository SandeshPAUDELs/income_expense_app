import 'package:finance_app/view_models/expense_vm.dart';
import 'package:finance_app/view_models/income_vm.dart';
import 'package:finance_app/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeExpense extends StatelessWidget {
  const IncomeExpense({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseViewModel =
        Provider.of<ExpenseViewModel>(context, listen: false);
    final incomeViewModel = Provider.of<IncomeViewModel>(context, listen: false);
    if (expenseViewModel.errorMessage.isNotEmpty && incomeViewModel.errorMessage.isNotEmpty) {
      return Center(child: Column(
        children: [
          Text(expenseViewModel.errorMessage),
          Text(incomeViewModel.errorMessage)
        ],
      ),
      );
    }

    if (expenseViewModel.expenseModel == null && incomeViewModel.incomeModel == null) {
      expenseViewModel.fetchExpenses();
      incomeViewModel.fetchIncomes();
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Income Expense'),
        ),
        body: Column(
          children: [
            Text(Provider.of<AuthViewModel>(context, listen: false)
                .authenticatedUser!
                .username),
            Text(Provider.of<IncomeViewModel>(context, listen: false)
                .incomeModel!
                .totalIncome
                .toString()),
            Text(Provider.of<ExpenseViewModel>(context, listen: false)
                .expenseModel!
                .totalExpense
                .toString())
          ],
        ));
  }
}
