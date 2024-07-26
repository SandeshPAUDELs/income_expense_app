import 'package:finance_app/model/expense_models.dart';
import 'package:finance_app/model/income_models.dart';
import 'package:finance_app/view_models/expense_vm.dart';
import 'package:finance_app/view_models/income_vm.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _expenseDescriptionController = TextEditingController();
  final TextEditingController _expenseAmountController = TextEditingController();
  final TextEditingController _expenseDateController = TextEditingController();
  final TextEditingController _expenseCategoryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Income And Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                onChanged: (value) {
                  setState(() {});
                },
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _dateController.text = '${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                    setState(() {});
                  }
                },
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _sourceController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: _otherSourceController,
                decoration: InputDecoration(labelText: 'Other Source'),
              ),
          
              TextField(
                controller: _expenseDateController,
                decoration: InputDecoration(labelText: 'Date'),
                onChanged: (value) {
                  setState(() {});
                },
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _expenseDateController.text = '${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                    setState(() {});
                  }
                },
              ),
              TextField(
                controller: _expenseNameController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _expenseAmountController,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: _expenseDescriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _expenseCategoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final title = _nameController.text;
                  final amount = _amountController.text;
                  final date = _dateController.text;
                  final description = _descriptionController.text;
                  final source = _sourceController.text;
                  final otherSource = _otherSourceController.text;
                  final expenseTitle = _expenseNameController.text;
                  final expenseAmount = _expenseAmountController.text;
                  final expenseDate = _expenseDateController.text;
                  final expenseDescription = _expenseDescriptionController.text;
                  final expenseCategory = _expenseCategoryController.text;
                  final addIncome = AddIncome(
                    title: title,
                    amount: amount,
                    date: DateTime.parse(date),
                    description: description,
                    source: source,
                    otherSource: otherSource,
                  );
                  Provider.of<IncomeViewModel>(context, listen: false).addIncome(addIncome, 'token');
                  final addExpenses = AddExpense(
                    title: expenseTitle,
                    amount: expenseAmount,
                    date: DateTime.parse(expenseDate),
                    description: expenseDescription,
                    category: expenseCategory,
                  
                );
                Provider.of<ExpenseViewModel>(context, listen: false).addExpense(addExpenses, 'token');
                },
                // Provider.of<ExpenseViewModel>(context, listen: false).addExpense(addExpenses, 'token');
                // },
                
          
                child: Text('Create Post'),
              ),
          
              
            ],
          ),
        ),
      ),
    );
  }

}

