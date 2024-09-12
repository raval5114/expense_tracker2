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
    //  int TransactionIndex = transactionList.length - 1;
    return Container(
      // height: 850,
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
                  "Recent Transaction",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
            width: 520,
            height: 320,
            color: Colors.white,
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (transactionList.isEmpty) {
                  return const Center(
                    child: Text(
                      'Transaction is not being done',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  return TransactionComponent(
                    title: transactionList[index].title.toString(),
                    category: transactionList[index].category.toString(),
                    amount: transactionList[index].amount.toString(),
                    expType: transactionList[index].transactionType.toString(),
                  );
                }
              },
              itemCount: transactionList.length,
            ),
          ),
        ],
      ),
    );
  }
}
