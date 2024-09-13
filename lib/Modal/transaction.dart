class Transaction {
  //late TransactionId;
  String title;
  String amount;
  String category;
  String discription;
  String transactionType;
  String bankType;
  var time;
  Transaction(
      {required this.title,
      required this.amount,
      required this.category,
      required this.discription,
      required this.transactionType,
      required this.bankType,
      required this.time});
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        title: json['title'],
        amount: json['amount'],
        category: json['category'],
        discription: json['discription'],
        transactionType: json['transactionType'],
        bankType: json['bankType'],
        time: json['time']);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'discription': discription,
      'transactionType': transactionType,
      'bankType': bankType,
      'time': time
    };
  }
}

class TransactionList {
  String email;
  String currentBalc;
  List<Transaction> transactionList;
  TransactionList(
      {required this.email,
      required this.currentBalc,
      required this.transactionList});

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    var transListFromJson = json['transactionList'] as List;
    List<Transaction> transList =
        transListFromJson.map((e) => Transaction.fromJson(e)).toList();
    return TransactionList(
        email: json['email'],
        currentBalc: json['currentBalc'],
        transactionList: transList);
  }

  Map<String, dynamic> tojson() {
    return {
      'currentBalc': currentBalc,
      'transactionList': transactionList.map((e) => e.toJson()).toList()
    };
  }
}
