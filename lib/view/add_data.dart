import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double hh = media.height;
    double ww = media.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(
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
            decoration: InputDecoration(
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
            children: [
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(
                    fontSize: hh * 0.018,
                    color: selected == "Income" ? Colors.white : Colors.black,
                  ),
                ),
                // selectedColor: Static.PrimaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      selected = "Income";
                    });
                  }
                },
                selected: selected == "Income" ? true : false,
              ),
              SizedBox(
                width: ww * 0.008,
              ),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: hh * 0.018,
                    color: selected == "Expense" ? Colors.white : Colors.black,
                  ),
                ),
                // selectedColor: Static.PrimaryColor,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      selected = "Expense";
                    });
                  }
                },
                selected: selected == "Expense" ? true : false,
              ),
            ],
          ),
          //
          TextButton(
            onPressed: () {
              _selectDate(context);
              print(selectedDate);
            },
            child: Row(
              children: [
                Icon(
                  Icons.date_range,
                  size: hh * 0.024,
                  // color: Colors.grey[700],
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  "${selectedDate.day} ${months[selectedDate.month - 1]}",
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
              //
              print(amount);
              print(selected);
              print(selectedDate);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              padding: EdgeInsets.symmetric(
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