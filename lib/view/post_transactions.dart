import 'package:finance_app/model/income_models.dart';
import 'package:finance_app/view_models/income_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class PostIncomesExpenses extends StatefulWidget {
  const PostIncomesExpenses({super.key});

  @override
  State<PostIncomesExpenses> createState() => _PostIncomesExpensesState();
}

class _PostIncomesExpensesState extends State<PostIncomesExpenses> {
  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
    final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _otherSourceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Company'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            // Rest of the form fields
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _nameController.text;
                final amount = _amountController.text;
                final date = _dateController.text;
                final description = _descriptionController.text;
                final source = _sourceController.text;
                final otherSource = _otherSourceController.text;
                final addIncome = AddIncome(
                  title: title,
                  amount: amount,
                  date: DateTime.parse(date),
                  description: description,
                  source: source,
                  otherSource: otherSource,
                );
                Provider.of<IncomeViewModel>(context, listen: false).addIncome(addIncome, 'token');
              },

              child: Text('Create Company'),
            ),

            
          ],
        ),
      ),
    );
  }

}

