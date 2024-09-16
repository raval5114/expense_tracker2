import 'package:expense_tracker2/Controller/Src/transactionComponent.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistory extends ConsumerStatefulWidget {
  const TransactionHistory({super.key});

  @override
  ConsumerState<TransactionHistory> createState() => TransactionHistoryState();
}

class TransactionHistoryState extends ConsumerState<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    final providerList = ref.watch(expenseTrackerProvider).transactionList;
    final transactionList = providerList.reversed.toList();

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: Colors.white,
            child: const Row(
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          // Check if transactionList is empty before building the ListView
          if (transactionList.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No transactions available',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          else
            Container(
              width: 520,
              height: 320,
              color: Colors.white,
              child: ListView.builder(
                itemCount: transactionList.length,
                itemBuilder: (context, index) {
                  return TransactionComponent(
                    title: transactionList[index].title.toString(),
                    category: transactionList[index].category.toString(),
                    amount: transactionList[index].amount.toString(),
                    expType: transactionList[index].transactionType.toString(),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
