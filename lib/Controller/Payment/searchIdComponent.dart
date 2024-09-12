import 'package:expense_tracker2/Modal/ElectricityBill.dart';
import 'package:expense_tracker2/Provider/billProvider.dart';
import 'package:expense_tracker2/Modal/billsApi.dart';
import 'package:expense_tracker2/Modal/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchIdComponent extends ConsumerStatefulWidget {
  final IconData categoryIcon;
  final String categoryName;
  final String searchId;

  const SearchIdComponent({
    super.key,
    required this.categoryIcon,
    required this.categoryName,
    required this.searchId,
  });

  @override
  _SearchIdComponentState createState() => _SearchIdComponentState();
}

class _SearchIdComponentState extends ConsumerState<SearchIdComponent> {
  List<Widget> addPaymentValue() {
    // Retrieve payment history from the provider
    final paymentHistory = ref.watch(billProvider).bill?.paymentHistory;

    // Check if paymentHistory is null or empty
    if (paymentHistory == null || paymentHistory.isEmpty) {
      return []; // Return an empty list if no payment history is available
    }

    // Map each PaymentHistory item to a PaymentInfo widget
    return paymentHistory
        .map(
          (PaymentHistory ph) => PaymentInfo(
            amount: ph.amountPaid.toString(),
            status: ph.status,
          ),
        )
        .toList(); // Convert the Iterable to a List
  }

  final TextEditingController consumerId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bill = ref.watch(billProvider).bill;

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Card(
            elevation: 10,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Icon(
                    widget.categoryIcon,
                    color: Colors.white,
                    size: 56,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.categoryName,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${widget.searchId}:",
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: consumerId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.blueAccent)),
                  onPressed: () async {
                    final retrievedBill =
                        await bilsAndStuffService.retrieveRecord(
                            ELECTRICITY_BILL_COLLECTION,
                            consumerId.text.toString());
                    ref.read(billProvider.notifier).addBill(retrievedBill!);
                  },
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (bill != null) // Render info only if data is available
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Information",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Consumer Id: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        bill.consumerNumber,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Consumer Name: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        bill.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        else
          const Center(
            child: Text(
              "No result found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key, required this.amount, required this.status});
  final String amount;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bill Amount: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          onPressed: () {},
          child: const Text(
            "Pay Now",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
