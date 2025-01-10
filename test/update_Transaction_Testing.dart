import 'package:expense_tracker2/Modal/transaction.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateTransactionTesting extends ConsumerStatefulWidget {
  const UpdateTransactionTesting({super.key});

  @override
  ConsumerState<UpdateTransactionTesting> createState() =>
      _UpdateTransactionTestingState();
}

class _UpdateTransactionTestingState
    extends ConsumerState<UpdateTransactionTesting> {
  TransactionList transactionList = TransactionList(
      email: "hariraval81@gmail.com",
      currentBalc: '12',
      transactionList: [
        Transaction(
          title: 'New Transaction',
          amount: '20000.00',
          category: 'Income',
          discription: 'Monthly salary',
          transactionType: 'Income', // Must be "Income" or "Expense"
          bankType: 'Current',
          time: DateTime.now().toIso8601String(),
        ),
        Transaction(
          title: 'Groceries',
          amount: '50.00',
          category: 'Food',
          discription: 'Bought groceries',
          transactionType: 'Expense', // Must be "Income" or "Expense"
          bankType: 'Savings',
          time: DateTime.now().toIso8601String(),
        ),
        Transaction(
          title: 'Salary',
          amount: '2000.00',
          category: 'Income',
          discription: 'Monthly salary',
          transactionType: 'Income', // Must be "Income" or "Expense"
          bankType: 'Current',
          time: DateTime.now().toIso8601String(),
        ),
        Transaction(
          title: 'Rent',
          amount: '500.00',
          category: 'Housing',
          discription: 'Paid rent',
          transactionType: 'Expense', // Must be "Income" or "Expense"
          bankType: 'Savings',
          time: DateTime.now().toIso8601String(),
        ),
      ]);

  Future<void> _submitFuture(WidgetRef ref) async {
    // Updating transactions for the given email

    try {
      ref.read(expenseTrackerProvider).loadData(transactionList.email);
      debugPrint('Loading Successfull');
    } catch (e) {
      debugPrint('$e');
    }

    //debugPrint('Transactions updated successfully');
  }

  void newEvent(WidgetRef ref) {
    ref.watch(expenseTrackerProvider).addTransaction(Transaction(
        title: "New Transaction-1",
        amount: "500",
        category: "Any Category",
        discription: "",
        transactionType: "Income",
        bankType: "SBI",
        time: DateTime.now().toIso8601String()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Transaction Testing"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _submitFuture(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    newEvent(ref);
                  },
                  child: const Text("Add transaction")),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
