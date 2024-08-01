import 'package:finance_app/view_models/expense_vm.dart';
import 'package:finance_app/view_models/income_vm.dart';
import 'package:finance_app/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeExpense extends StatelessWidget {
  const IncomeExpense({super.key});

  @override
  Widget build(BuildContext context) {
    final hh = MediaQuery.of(context).size.height;

    final expenseViewModel =
        Provider.of<ExpenseViewModel>(context, listen: false);
    final incomeViewModel =
        Provider.of<IncomeViewModel>(context, listen: false);
    if (expenseViewModel.errorMessage.isNotEmpty &&
        incomeViewModel.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          children: [
            Text(expenseViewModel.errorMessage),
            Text(incomeViewModel.errorMessage)
          ],
        ),
      );
    }

    if (expenseViewModel.expenseModel == null &&
        incomeViewModel.incomeModel == null) {
      expenseViewModel.fetchExpenses();
      incomeViewModel.fetchIncomes();
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Income Expense'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        32.0,
                      ),
                      // color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const CircleAvatar(
                      maxRadius: 28.0,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.verified_user_rounded),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Hello, ${Provider.of<AuthViewModel>(context, listen: false).authenticatedUser!.username}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        // color: Static.PrimaryMaterialColor[800],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.logout,
                    size: 32.0,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            ),
            //
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(
                12.0,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Total Balance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: hh * 0.028,
                        // color: Colors.white,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(
                      height: hh * 0.008,
                    ),
                    Text(
                      // 'Rs 32000',
                      'Rs ${incomeViewModel.incomeModel!.totalIncome + expenseViewModel.expenseModel!.totalExpense}',

                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: hh * 0.036,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    SizedBox(
                      height: hh * 0.012,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(
                              6.0,
                            ),
                            margin: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: Icon(
                              Icons.arrow_downward,
                              size: 28.0,
                              color: Colors.green[700],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.amber,
                                  // color: Colors.white70,
                                ),
                              ),
                              Text(
                                'Rs ${incomeViewModel.incomeModel!.totalIncome}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  // color: Colors.white,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(
                              6.0,
                            ),
                            margin: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: Icon(
                              Icons.arrow_upward,
                              size: 28.0,
                              color: Colors.red[700],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.amber,
                                  // color: Colors.white70,
                                ),
                              ),
                              Text(
                                '${expenseViewModel.expenseModel!.totalExpense}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  // color: Colors.white,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
