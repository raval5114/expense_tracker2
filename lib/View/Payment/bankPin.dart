import 'package:expense_tracker2/Controller/Payment/bankPinComponent.dart';
import 'package:flutter/material.dart';

class BankPassword extends StatefulWidget {
  const BankPassword({super.key});

  @override
  State<BankPassword> createState() => _BankPasswordState();
}

class _BankPasswordState extends State<BankPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN'),
        centerTitle: true,
      ),
      body: const BankPasswordComponent(),
    );
  }
}
