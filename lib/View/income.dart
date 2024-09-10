import 'package:expense_tracker2/Controller/IncomeAndExpenseForm/incomeForm.dart';
import 'package:flutter/material.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Income",
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 30,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        children: const [
          Padding(padding: EdgeInsets.all(20.0), child: IncomeComponent())
        ],
      ),
    );
  }
}
