import 'package:expense_tracker2/Controller/Payment/bankPinComponent.dart';
import 'package:flutter/material.dart';

class BankPassword extends StatefulWidget {
  String state;
  String defaultDropDownValue;
  String mobileNo;
  String amount;
  String cvv;
  String email;
  BankPassword(
      {super.key,
      required this.state,
      required this.defaultDropDownValue,
      required this.cvv,
      required this.amount,
      required this.mobileNo,
      required this.email});

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
      body: BankPasswordComponent(
        state: widget.state,
        defaultDropDownValue: widget.defaultDropDownValue,
        mobileNo: widget.mobileNo,
        amount: widget.amount,
        cvv: widget.cvv,
        email: widget.email,
      ),
    );
  }
}
