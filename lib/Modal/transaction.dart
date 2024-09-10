class Transaction {
  //late TransactionId;
  String title;
  String amount;
  String category;
  String discription;
  String transactionType;
  var time;
  Transaction(
      {required this.title,
      required this.amount,
      required this.category,
      required this.discription,
      required this.transactionType,
      required this.time});
}
