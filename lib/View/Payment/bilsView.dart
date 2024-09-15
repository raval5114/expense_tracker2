import 'package:expense_tracker2/View/Payment/ElectricityBills/searchId.dart';
import 'package:expense_tracker2/View/Payment/GasBills/gasBill.dart';
import 'package:expense_tracker2/View/Payment/TvBill/tvBill.dart';
import 'package:expense_tracker2/View/Payment/WifiBill/wifiBill.dart';
import 'package:flutter/material.dart';

class BillsView extends StatefulWidget {
  const BillsView({super.key});

  @override
  State<BillsView> createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Bills"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 15, // Horizontal spacing between items
            mainAxisSpacing: 15, // Vertical spacing between items
            childAspectRatio: 1, // Aspect ratio for each grid item
          ),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ElectricityBillView(),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lightbulb_circle,
                    size: 50, // Icon size
                    color: Colors.white, // Icon color
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GasBillView(),
                    ));

                // Handle tap
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.gas_meter_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TvBillView(),
                    ));
                // Handle tap
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.router,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Handle tap
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WifiBillView(),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.wifi,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
