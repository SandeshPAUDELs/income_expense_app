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
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return expenseViewModel.fetchExpenses();
        },
        child: expenseViewModel.expenseModel!.expenses.isEmpty
            ? const Center(
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Icon(
                      Icons.no_accounts,
                      size: 200,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No Expenses',
                    ),
                    Text(
                      'Once you add expenses, they will appear here',
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: expenseViewModel.expenseModel!.expenses.length,
                itemBuilder: (context, index) {
                  var expense = expenseViewModel.expenseModel!.expenses[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 10.0),
                      leading: CircleAvatar(
                        radius: 40,
                        child: Text(
                          expense.category.substring(0, 3),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      title: Text(
                        expense.title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4.0),
                          Text(
                            'Rs ${expense.amount} /-',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          // Spacer(),
                          Text(expense.date.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          IconButton(
                            onPressed: () => expenseViewModel
                                .deleteExpense(expense.id, context)
                                .then((value) =>
                                    expenseViewModel.fetchExpenses()),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const Icon(Icons.edit),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
