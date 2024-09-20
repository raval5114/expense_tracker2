import 'dart:math';

import 'package:expense_tracker2/Modal/auth.dart';
import 'package:expense_tracker2/Modal/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ExpenseTracker extends ChangeNotifier {
  late String email;
  late int currentBalc;
  late int expenses;
  late int income;
  List<Transaction> transactionList = [];

  void loadExpenseAndData() {
    //loading na
    transactionList.map((Transaction e) {
      e.transactionType == "Income"
          ? income += int.parse(e.amount)
          : expenses += int.parse(e.amount);
    });
  }

  Future<void> loadData(String email) async {
    // Await the result from the authService
    Map<String, dynamic>? transList =
        await authService.findAndLoadTransaction(email);
    debugPrint('loadData working ...');
    if (transList != null) {
      // Use TransactionList.fromJson to parse the response
      TransactionList transactionList2 = TransactionList.fromJson(transList);

      // Set class properties using 'this' to refer to the instance variables
      this.email = transactionList2.email;
      this.currentBalc = int.parse(transactionList2.currentBalc);
      this.transactionList = transactionList2.transactionList;
      debugPrint('Transactions are recorded');
      // Notify listeners to update UI
      notifyListeners();
    } else {
      // Handle the case where no transactions are found (if necessary)
      print("No transaction found for email: $email");
    }
  }

  void addTransaction(Transaction t) {
    if (t != null) {
      if (!transactionList.contains(t)) {
        // Avoid duplicates if needed
        transactionList.add(t);
        authService.updateTransaction(email, transactionList);
        notifyListeners(); // Notify listeners about the change
        print("Transaction added and updated successfully.");
      }
    }
  }
}

final expenseTrackerProvider = ChangeNotifierProvider<ExpenseTracker>((ref) {
  return ExpenseTracker();
});
