import 'package:expense_tracker2/Controller/IncomeAndExpenseForm/expenseForm.dart';
import 'package:flutter/material.dart';

class AddExpensesPage extends StatefulWidget {
  const AddExpensesPage({super.key});

  @override
  State<AddExpensesPage> createState() => _AddExpensesPageState();
}

class _AddExpensesPageState extends State<AddExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expenses',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 30,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        children: const [
          Padding(padding: EdgeInsets.all(20.0), child: ExpenseForm())
        ],
      ),
    );
  }
}
