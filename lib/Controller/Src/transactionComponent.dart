import 'package:flutter/material.dart';

class TransactionComponent extends StatefulWidget {
  const TransactionComponent({
    required this.title,
    required this.category,
    required this.amount,
    required this.expType,
    super.key,
  });

  final String title;
  final String category;
  final String amount;
  final String expType;

  @override
  State<TransactionComponent> createState() => _TransactionComponentState();
}

class _TransactionComponentState extends State<TransactionComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          widget.expType == "Income"
              ? Icons.arrow_circle_up_outlined // Icon for income
              : Icons.arrow_circle_down_outlined, // Icon for expense
          color: widget.expType == "Income"
              ? Colors.green
              : Colors.red, // Color based on type
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: Text(widget.category),
        trailing: widget.expType == "Income"
            ? IncomeText(text: widget.amount)
            : ExpensesText(text: widget.amount),
      ),
    );
  }
}

class IncomeText extends StatelessWidget {
  final String text;
  const IncomeText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "+$text",
      style: const TextStyle(fontSize: 20, color: Colors.green),
    );
  }
}

class ExpensesText extends StatelessWidget {
  final String text;
  const ExpensesText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "-$text",
      style: const TextStyle(fontSize: 20, color: Colors.red),
    );
  }
}
