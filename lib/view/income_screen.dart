
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/view_models/income_vm.dart';

class Income extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incomes'),
      ),
      body: Consumer<IncomeViewModel>(
        builder: (context, incomeViewModel, child) {
          if (incomeViewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(incomeViewModel.errorMessage));
          }

          if (incomeViewModel.incomeModel == null) {
            incomeViewModel.fetchIncomes();
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: incomeViewModel.incomeModel!.incomes.length,
            itemBuilder: (context, index) {
              var income = incomeViewModel.incomeModel!.incomes[index];
              return ListTile(
                title: Text(income.title),
                subtitle: Text(income.description),
              );
            },
          );
        },
      ),
    );
  }
}
