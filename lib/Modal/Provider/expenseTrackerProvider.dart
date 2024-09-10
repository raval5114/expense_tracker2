import 'package:expense_tracker2/Modal/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ExpenseTracker extends ChangeNotifier {
  late int currentBalc;
  List transactionList = <Transaction>[];
  ExpenseTracker(this.currentBalc, this.transactionList);
  void addExpense(
      String amount, String title, String category, String description) {
    currentBalc = currentBalc - int.parse(amount);
    transactionList.add(Transaction(
        title: title,
        amount: amount,
        category: category,
        discription: description,
        transactionType: 'Expense',
        time: DateTime.now()));
    debugPrint('${transactionList.length}');
    notifyListeners();
  }

  void addIncome(
      String amount, String title, String category, String description) {
    currentBalc = currentBalc + int.parse(amount);
    transactionList.add(Transaction(
        title: title,
        amount: amount,
        category: category,
        discription: description,
        transactionType: 'Income',
        time: DateTime.now()));
    debugPrint('${transactionList.length}');
    notifyListeners();
  }
}

final expenseTrackerProvider = ChangeNotifierProvider<ExpenseTracker>((ref) {
  return ExpenseTracker(0000, []);
});
