import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/view_models/income_vm.dart';

class Income extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incomeViewModel = Provider.of<IncomeViewModel>(context);

    if (incomeViewModel.errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Incomes'),
        ),
        body: Center(child: Text(incomeViewModel.errorMessage)),
      );
    }

    if (incomeViewModel.incomeModel == null) {
      incomeViewModel.fetchIncomes();
      return Scaffold(
        appBar: AppBar(
          title: Text('Incomes'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Incomes'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return incomeViewModel.fetchIncomes();
        },
        child: ListView.builder(
          itemCount: incomeViewModel.incomeModel!.incomes.length,
          itemBuilder: (context, index) {
            var income = incomeViewModel.incomeModel!.incomes[index];

            return Card(
              // elevation: 2.0,
              margin: const EdgeInsets.only(bottom: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                leading: CircleAvatar(
                  radius: 40,
                  child: Text(
                    income.source.substring(0, 3),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                title: Text(
                  income.title,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4.0),
                    Text(
                      'Rs ${income.amount} /-',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    // Spacer(),
                    Text(income.date.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.tertiary)),
                  ],
                ),
                trailing: IconButton.outlined(
                  onPressed: () => incomeViewModel
                      .deleteIncome(income.id)
                      .then((value) => incomeViewModel.fetchIncomes()),
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
