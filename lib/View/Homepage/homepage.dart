import 'package:expense_tracker2/Controller/Features/features.dart';
import 'package:expense_tracker2/Controller/Homepage/actionCard.dart';
import 'package:expense_tracker2/Controller/Homepage/appBar.dart';
import 'package:expense_tracker2/Controller/Homepage/drawerComponent.dart';
import 'package:expense_tracker2/Controller/transactionHistory.dart';
import 'package:expense_tracker2/Modal/Provider/sessionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(sessionProvider).user;
    final lastName =
        user?.lastName ?? 'User'; // Use 'User' as default if lastName is null

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Namastae",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            ),
            Text("Mr $lastName")
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
              TransactionHistory()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),
        ],
      ),
    );
  }
}
