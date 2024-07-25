class ExpenseModel {
  double totalExpense;
  List<Expense> expenses;

  ExpenseModel({
    required this.totalExpense,
    required this.expenses,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        totalExpense: json["total_expense"].toDouble(),
        expenses: List<Expense>.from(json["expenses"].map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_expense": totalExpense,
        "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
      };
}

class Expense {
  int id;
  String title;
  String amount;
  DateTime date;
  String description;
  String category;
  int user;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    required this.category,
    required this.user,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        category: json["category"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description,
        "category": category,
        "user": user,
      };
}
