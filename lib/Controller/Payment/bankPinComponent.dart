import 'package:expense_tracker2/Modal/transaction.dart';
import 'package:expense_tracker2/Provider/accountProvider.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:expense_tracker2/View/Homepage/homepage.dart';
import 'package:expense_tracker2/View/Payment/payment.dart';
import 'package:expense_tracker2/View/Transfer/transferView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BankPasswordComponent extends ConsumerStatefulWidget {
  String state;
  String mobileNo;
  String defaultDropDownValue;
  String cvv;
  String amount;
  String email;
  BankPasswordComponent(
      {super.key,
      required this.state,
      required this.defaultDropDownValue,
      required this.mobileNo,
      required this.amount,
      required this.cvv,
      required this.email});

  @override
  ConsumerState<BankPasswordComponent> createState() =>
      _BankPasswordComponentState();
}

class _BankPasswordComponentState extends ConsumerState<BankPasswordComponent> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  late final FocusNode _initialFocusNode;

  @override
  void initState() {
    super.initState();
    _initialFocusNode = _focusNodes[0]; // Focus on the first field by default
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_initialFocusNode);
    });
  }

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

    // Handle password submission logic here
    if (password == '123456') {
      if (widget.state == 'mobileNumber') {
        debugPrint('From MobileNumber');
        ref
            .watch(accountProvider)
            .billPaymentWithMobileNumber(ref, widget.mobileNo, widget.amount);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Text('Amount Transfer Successfully'),
              content: const Text('Transaction is being done'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ));
                  },
                  child: const Text('OK'),
                )
              ]),
        );
      }
      if (widget.state == 'email') {
        debugPrint('From Card');
        ref.watch(accountProvider).billPaymentWithCard(
            ref,
            widget.defaultDropDownValue,
            widget.cvv,
            widget.amount,
            widget.email);
        ref.watch(expenseTrackerProvider).addTransaction(Transaction(
            title: 'Bill payment',
            amount: widget.amount,
            category: 'Bills',
            discription: '',
            transactionType: 'Expense',
            bankType: '',
            time: DateTime.now().toIso8601String()));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Text('Amount Transfer Successfully'),
              content: const Text('Transaction is being done'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ));
                  },
                  child: const Text('OK'),
                )
              ]),
        );
      }
      if (widget.state == 'Transfer') {
        debugPrint('For Transfer');
        ref.watch(accountProvider).transferEvent(ref, widget.amount);
        ref.watch(expenseTrackerProvider).addTransaction(Transaction(
            title: 'Personal Transfer',
            amount: widget.amount,
            category: 'Transfer',
            discription: '',
            transactionType: 'Expense',
            bankType: '',
            time: DateTime.now().toIso8601String()));

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Text('Amount Transfer Successfully'),
              content: const Text('Transaction is being done'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Pop until the second route from the top
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('back to hompage'),
                ),
                TextButton(
                  onPressed: () {
                    // Pop the alert box
                    Navigator.pop(context);
                  },
                  child: const Text('cancel'),
                )
              ]),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter the 6-digit bank-provided password to proceed with the transaction.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _moveToNextField(index);
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _submitPassword,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50), // Button height
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              'Submit PIN',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
