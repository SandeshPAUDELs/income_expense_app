import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/model/data.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime selectedDate = DateTime.now();
  int? amount;

  String selected = "Income";

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: context.read<DateSelectorProvider>().selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != context.read<DateSelectorProvider>().selectedDate) {
      context.read<DateSelectorProvider>().setTransactionData(
        date: picked,
       
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double hh = media.height;
    // double ww = media.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(
          12.0,
        ),
        children: [
          Text(
            "\nAdd Expense/Income",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: hh * 0.032,
              fontWeight: FontWeight.w700,
            ),
          ),
          //
          TextField(
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: hh * 0.024,
            ),
            onChanged: (val) {
              amount = int.parse(val);
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: hh * 0.012,
          ),
          //
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text(
                    "Income",
                    style: TextStyle(
                      fontSize: 18,
                      color: context.watch<SelectedTypeProvider>().selectedType == "Income"
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  onSelected: (val) {
                    if (val) {
                      context.read<SelectedTypeProvider>().setSelectedType("Income");
                    }
                  },
                  selected: context.watch<SelectedTypeProvider>().selectedType == "Income",
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 18,
                      color: context.watch<SelectedTypeProvider>().selectedType == "Expense"
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  onSelected: (val) {
                    if (val) {
                      context.read<SelectedTypeProvider>().setSelectedType("Expense");
                    }
                  },
                  selected: context.watch<SelectedTypeProvider>().selectedType == "Expense",
                ),
              ],
            ),
        
          TextButton(
            onPressed: () {
              _selectDate(context);
              // print(selectedDate);
            },
            child: Row(
              children: [
                Icon(
                  Icons.date_range,
                  size: hh * 0.024,
                  // color: Colors.grey[700],
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  "${context.watch<DateSelectorProvider>().selectedDate.day} "
                  "${months[context.watch<DateSelectorProvider>().selectedDate.month - 1]}",
                  style: TextStyle(
                    fontSize: hh * 0.024,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ],
            ),
          ),
          //
          SizedBox(
            height: hh * 0.012,
          ),
          InkWell(
            onTap: () {
              // //
              // print(amount);
              // print(selected);
              // print(selectedDate);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              alignment: Alignment.center,
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  // color: Colors.white,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


