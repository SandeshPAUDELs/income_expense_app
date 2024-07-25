class IncomeModel {
  double totalIncome;
  List<Income> incomes;

  IncomeModel({
    required this.totalIncome,
    required this.incomes,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        totalIncome: json["total_income"].toDouble(),
        incomes: List<Income>.from(json["incomes"].map((x) => Income.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_income": totalIncome,
        "incomes": List<dynamic>.from(incomes.map((x) => x.toJson())),
      };
}

class Income {
  int id;
  String title;
  String amount;
  DateTime date;
  String description;
  String source;
  String? otherSource;
  int user;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    required this.source,
    this.otherSource,
    required this.user,
  });

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        source: json["source"],
        otherSource: json["other_source"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description,
        "source": source,
        "other_source": otherSource,
        "user": user,
      };
}

class AddIncome {
  final String title;
  final String amount;
  final DateTime date;
  final String description;
  final String source;
  final String? otherSource;
  AddIncome({
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    required this.source,
    this.otherSource
  });
  factory AddIncome.fromJson(Map<String, dynamic> json){
    return AddIncome(title: json['title'], amount: json['amount'], date: json['date'], description: json['description'], source: json['source'], otherSource: json['otherSource']);

  }
  Map<String, dynamic> toJson() => {
    'title': title,
    'amount': amount,
    'date': "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    'description': description,
    'source': source,
    'otherSource': otherSource

  };

}