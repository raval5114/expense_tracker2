import 'package:expense_tracker2/View/Payment/ElectricityBills/searchId.dart';
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
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
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
          Row(
            children: [
              FeatureComponent(
                text: "Transfer",
                featureIconData: Icons.send,
                callback: () {
                  debugPrint('Transfer feature clicked');
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
                        builder: (context) => const SearchId(),
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

class FeatureComponent extends StatefulWidget {
  const FeatureComponent(
      {super.key,
      required this.text,
      required this.featureIconData,
      required this.callback});

  final String text;
  final IconData featureIconData;
  final VoidCallback callback;

  @override
  State<FeatureComponent> createState() => _FeatureComponentState();
}

class _FeatureComponentState extends State<FeatureComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  widget.featureIconData,
                  size: 32,
                  color: Colors.blueAccent,
                )),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                widget.text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
