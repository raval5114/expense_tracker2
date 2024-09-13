import 'package:expense_tracker2/Controller/Charts/Pie/pieChart.dart';
import 'package:expense_tracker2/Controller/Features/features.dart';
import 'package:expense_tracker2/Controller/Features/Homepage/actionCard.dart';
import 'package:expense_tracker2/Controller/Features/Homepage/appBar.dart';
import 'package:expense_tracker2/Controller/Features/Homepage/drawerComponent.dart';
import 'package:expense_tracker2/Controller/Src/transactionHistory.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:expense_tracker2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();

    final userEmail = ref.read(sessionProvider).user?.email;

    if (userEmail != null) {
      // Call loadData only once during initialization
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(expenseTrackerProvider).loadData(userEmail);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(sessionProvider).user;
    final lastName = user?.lastName ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Namastae",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            ),
            Text("Mr $lastName"),
          ],
        ),
      ),
      drawer: const DrawerComponent(),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BalanceCardComponent(),
              Features(),
              TransactionHistory(),
              AllPieChartComponents()
            ],
          ),
        ),
      ),
    );
  }
}
