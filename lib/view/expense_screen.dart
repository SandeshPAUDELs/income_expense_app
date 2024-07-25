import 'package:finance_app/view_models/expense_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expense extends StatelessWidget {
  const Expense({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseViewModel =
        Provider.of<ExpenseViewModel>(context, listen: false);
    if (expenseViewModel.errorMessage.isNotEmpty) {
      return Center(child: Text(expenseViewModel.errorMessage));
    }

    if (expenseViewModel.expenseModel == null) {
      expenseViewModel.fetchExpenses();
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: ListView.builder(
        itemCount: expenseViewModel.expenseModel!.expenses.length,
        itemBuilder: (context, index) {
          var expense = expenseViewModel.expenseModel!.expenses[index];
          return ListTile(
            title: Text(expense.title),
            subtitle: Text(expense.description),
          );
        },
      ),
    );
  }
}
