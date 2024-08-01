import 'package:finance_app/model/expense_models.dart';
import 'package:finance_app/model/income_models.dart';
import 'package:finance_app/view_models/expense_vm.dart';
import 'package:finance_app/view_models/income_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PostIncomesExpenses extends StatefulWidget {
  const PostIncomesExpenses({super.key});

  @override
  State<PostIncomesExpenses> createState() => _PostIncomesExpensesState();
}

class _PostIncomesExpensesState extends State<PostIncomesExpenses> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _otherSourceController = TextEditingController();

  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseDescriptionController =
      TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();
  final TextEditingController _expenseDateController = TextEditingController();
  final TextEditingController _expenseCategoryController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text(
          'Add Income And Expense',
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 100,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DefaultTabController(
                    length: 2,
                    child: Builder(builder: (context) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              Expanded(
                                flex: 20,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const TabBar(
                                    tabs: [
                                      Tab(
                                        text: 'Add Income',
                                      ),
                                      Tab(text: 'Add Expense'),
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ScrollConfiguration(
                                            behavior: const ScrollBehavior()
                                                .copyWith(overscroll: true),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  TextField(
                                                    controller: _dateController,
                                                    decoration: const InputDecoration(
                                                        labelText: 'Date'),
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                    onTap: () async {
                                                      final DateTime?
                                                          pickedDate =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime(2100),
                                                      );
                                                      if (pickedDate != null) {
                                                        _dateController.text =
                                                            '${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                  TextField(
                                                    controller: _nameController,
                                                    decoration: const InputDecoration(
                                                        labelText: 'Title'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _amountController,
                                                    decoration: const InputDecoration(
                                                        labelText: 'Amount'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _descriptionController,
                                                    decoration: const InputDecoration(
                                                        labelText:
                                                            'Description'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _sourceController,
                                                    decoration: const InputDecoration(
                                                        labelText: 'Source'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _otherSourceController,
                                                    decoration: const InputDecoration(
                                                        labelText:
                                                            'Other Source'),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      final title =
                                                          _nameController.text;
                                                      final amount =
                                                          _amountController
                                                              .text;
                                                      final date =
                                                          _dateController.text;
                                                      final description =
                                                          _descriptionController
                                                              .text;
                                                      final source =
                                                          _sourceController
                                                              .text;
                                                      final otherSource =
                                                          _otherSourceController
                                                              .text;

                                                      final addIncome =
                                                          AddIncome(
                                                        title: title,
                                                        amount: amount,
                                                        date: DateTime.parse(
                                                            date),
                                                        description:
                                                            description,
                                                        source: source,
                                                        otherSource:
                                                            otherSource,
                                                      );
                                                      Provider.of<IncomeViewModel>(
                                                              context,
                                                              listen: false)
                                                          .addIncome(addIncome,
                                                              'token');
                                                    },
                                                    // Provider.of<ExpenseViewModel>(context, listen: false).addExpense(addExpenses, 'token');
                                                    // },

                                                    child: const Text('Post Income'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ScrollConfiguration(
                                  behavior: const ScrollBehavior()
                                      .copyWith(overscroll: true),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: _expenseDateController,
                                            decoration: const InputDecoration(
                                                labelText: 'Date'),
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            onTap: () async {
                                              final DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );
                                              if (pickedDate != null) {
                                                _expenseDateController.text =
                                                    '${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          TextField(
                                            controller: _expenseNameController,
                                            decoration: const InputDecoration(
                                                labelText: 'Title'),
                                          ),
                                          TextField(
                                            controller:
                                                _expenseAmountController,
                                            decoration: const InputDecoration(
                                                labelText: 'Amount'),
                                          ),
                                          TextField(
                                            controller:
                                                _expenseDescriptionController,
                                            decoration: const InputDecoration(
                                                labelText: 'Description'),
                                          ),
                                          TextField(
                                            controller:
                                                _expenseCategoryController,
                                            decoration: const InputDecoration(
                                                labelText: 'Category'),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              final expenseTitle =
                                                  _expenseNameController.text;
                                              final expenseAmount =
                                                  _expenseAmountController.text;
                                              final expenseDate =
                                                  _expenseDateController.text;
                                              final expenseDescription =
                                                  _expenseDescriptionController
                                                      .text;
                                              final expenseCategory =
                                                  _expenseCategoryController
                                                      .text;

                                              final addExpenses = AddExpense(
                                                title: expenseTitle,
                                                amount: expenseAmount,
                                                date:
                                                    DateTime.parse(expenseDate),
                                                description: expenseDescription,
                                                category: expenseCategory,
                                              );
                                              Provider.of<ExpenseViewModel>(
                                                      context,
                                                      listen: false)
                                                  .addExpense(
                                                      addExpenses, 'token');
                                            },
                                            // Provider.of<ExpenseViewModel>(context, listen: false).addExpense(addExpenses, 'token');
                                            // },

                                            child: const Text('Post Expense'),
                                            // Text('hello 2'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    })),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
