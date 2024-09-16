import 'package:expense_tracker2/Modal/ElectricityBill.dart';
import 'package:expense_tracker2/Provider/billProvider.dart';
import 'package:expense_tracker2/Modal/billsApi.dart';
import 'package:expense_tracker2/Modal/const.dart';
import 'package:expense_tracker2/View/Payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchIdComponent extends ConsumerStatefulWidget {
  final IconData categoryIcon;
  final String categoryName;
  final String searchId;
  final String collectionName;

  const SearchIdComponent(
      {super.key,
      required this.categoryIcon,
      required this.categoryName,
      required this.searchId,
      required this.collectionName});

  @override
  _SearchIdComponentState createState() => _SearchIdComponentState();
}

class _SearchIdComponentState extends ConsumerState<SearchIdComponent> {
  @override
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

  String? name;
  String? consumerID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = null;
    consumerID;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController consumerId = TextEditingController();

    var bill = ref.watch(billProvider).bill;

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
                      widget.collectionName,
                      consumerId.text.toString(),
                    );
                    try {
                      if (retrievedBill != null) {
                        ref.read(billProvider.notifier).addBill(retrievedBill);

                        // Using setState to trigger a UI update after adding the bill
                        setState(() {
                          name = retrievedBill.name;
                          consumerID = retrievedBill.consumerNumber;
                        });
                      }
                    } catch (e) {
                      debugPrint('$e');
                    }
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
                        ref.watch(billProvider).bill?.consumerNumber ?? 'N/A',
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
                        ref.watch(billProvider).bill?.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ...addPaymentValue(),
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
  final String amount;
  final String status;

  const PaymentInfo({
    super.key,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Section header for each bill

            // Bill amount and status
            _buildRow("Bill Amount:", amount),
            _buildRow("Status:", status),

            // "Pay Now" button only if status is Unpaid
            if (status == 'Unpaid')
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Payment(),
                        ));
                  },
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each row of information
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
