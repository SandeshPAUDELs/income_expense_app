
import 'package:finance_app/view/expense_screen.dart';
import 'package:finance_app/view/income_expense.dart';
import 'package:finance_app/view/income_screen.dart';
import 'package:finance_app/view/post_transactions.dart';
import 'package:finance_app/view_models/navigation_vm.dart';
import 'package:flutter/material.dart'
    show BuildContext, Icon, Icons, NavigationBar, NavigationDestination, Placeholder, Scaffold, StatelessWidget, Widget;
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navVM = Provider.of<NavigationViewModel>(context);

    // Function to get the current screen
    Widget getCurrentScreen(int index) {
      switch (index) {
        case 0:
          return IncomeExpense();
        case 1:
          return Income();
        case 2:
          return Expense();
        case 3:
          return const PostIncomesExpenses();
        
        default:
          return IncomeExpense();
      }
    }

    return Scaffold(
      body: getCurrentScreen(navVM.currentHomeIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navVM.currentHomeIndex,
        onDestinationSelected: (index) {
          navVM.changeHomeIndex(index);
        },

        // tooltip: ''   removes the label displayed at top when
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            tooltip: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Income',
            tooltip: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Expenses',
            tooltip: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'PostIncome/Expenses',
            tooltip: '',
          ),
          
        ],
      ),
    );
  }
}
