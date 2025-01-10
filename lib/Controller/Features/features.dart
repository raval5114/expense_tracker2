import 'package:expense_tracker2/View/Add%20Expenses/addExpense.dart';
import 'package:expense_tracker2/View/Add%20Income/addIncome.dart';
import 'package:expense_tracker2/View/Payment/bilsView.dart';
import 'package:expense_tracker2/View/Transfer/transferView.dart';
import 'package:flutter/material.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Features",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Icon(
                Icons.more_horiz_outlined,
                size: 34,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 10,
            children: [
              FeatureComponent(
                text: "Transfer",
                featureIconData: Icons.send,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferPage(),
                      ));
                },
              ),
              FeatureComponent(
                text: "Receive",
                featureIconData: Icons.download,
                callback: () {
                  debugPrint('Receive feature clicked');
                },
              ),
              FeatureComponent(
                text: "Subscription",
                featureIconData: Icons.subscriptions,
                callback: () {
                  debugPrint('Subscription feature clicked');
                },
              ),
              FeatureComponent(
                text: "Bills",
                featureIconData: Icons.receipt_long,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BillsView(),
                      ));
                },
              ),
              FeatureComponent(
                text: "Add Expense",
                featureIconData: Icons.account_balance_wallet,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddExpense(),
                      ));
                },
              ),
              FeatureComponent(
                text: "Add Income",
                featureIconData: Icons.account_balance_wallet,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddIncome(),
                      ));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class FeatureComponent extends StatelessWidget {
  const FeatureComponent({
    super.key,
    required this.text,
    required this.featureIconData,
    required this.callback,
  });

  final String text;
  final IconData featureIconData;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: 120, // Set fixed width
        height: 140, // Set fixed height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                child: Icon(
                  featureIconData,
                  size: 32,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center, // Center text
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
