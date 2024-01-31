
import 'package:flutter/material.dart';

class SelectedTypeProvider with ChangeNotifier {
  String _selectedType = "Income";

  String get selectedType => _selectedType;

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }
}


// class DateSelectorProvider with ChangeNotifier {
//     late DateTime _selectedDate;

//       DateTime get selectedDate => _selectedDate;
//       void setTransactionData({
//     required DateTime date,

//   }) {
//     _selectedDate = date;
//     notifyListeners();
//   }
// }
class DateSelectorProvider with ChangeNotifier {
  late DateTime _selectedDate;

  DateSelectorProvider() {
    _selectedDate = DateTime.now(); // Initialize _selectedDate in the constructor
  }

  DateTime get selectedDate => _selectedDate;

  void setTransactionData({
    required DateTime date,
  }) {
    _selectedDate = date;
    notifyListeners();
  }
}

