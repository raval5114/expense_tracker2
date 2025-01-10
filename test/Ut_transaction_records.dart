import 'package:expense_tracker2/Controller/Src/transactionHistory.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionViewComponent extends ConsumerStatefulWidget {
  const TransactionViewComponent({super.key});

  @override
  ConsumerState<TransactionViewComponent> createState() =>
      _TransactionViewComponentState();
}

class _TransactionViewComponentState
    extends ConsumerState<TransactionViewComponent> {
  @override
  void initState() {
    super.initState();
    // Call loadData in initState to avoid multiple calls during rebuilds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseTrackerProvider).loadData("hariraval81@gmail.com");
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseTracker = ref.watch(expenseTrackerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction'),
      ),
      body: expenseTracker.transactionList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : const TransactionHistory(), // Display data when it's loaded
    );
  }
}
