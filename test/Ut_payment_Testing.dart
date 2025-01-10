import 'package:expense_tracker2/Controller/Payment/paymentnMethods.dart';
import 'package:flutter/material.dart';

class PaymentTesting extends StatefulWidget {
  const PaymentTesting({super.key});

  @override
  State<PaymentTesting> createState() => _PaymentTestingState();
}

class _PaymentTestingState extends State<PaymentTesting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Testing"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            PayWithNumbers(),
          ],
        ),
      ),
    );
  }
}
