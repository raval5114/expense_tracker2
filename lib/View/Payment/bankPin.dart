import 'package:expense_tracker2/Controller/Payment/bankPinComponent.dart';
import 'package:flutter/material.dart';

class BankPassword extends StatefulWidget {
  const BankPassword({super.key});

  @override
  State<BankPassword> createState() => _BankPasswordState();
}

class _BankPasswordState extends State<BankPassword> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _moveToNextField(int index) {
    if (index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      FocusScope.of(context).unfocus(); // Close the keyboard after last input
    }
  }

  void _submitPassword() {
    String password = _controllers.map((controller) => controller.text).join();
    print('UPI Password: $password');
    // Handle password submission logic here
  }

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
