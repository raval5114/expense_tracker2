import 'package:expense_tracker2/Controller/Payment/paymentnMethods.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final List<Widget> _tabs = [const PayWithCards(), const PayWithNumbers()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Payment"),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Pay With Debit-Card',
              ),
              Tab(
                text: 'Pay with Mobile-Number',
              )
            ]),
          ),
          body: TabBarView(children: _tabs),
        ));
  }
}
