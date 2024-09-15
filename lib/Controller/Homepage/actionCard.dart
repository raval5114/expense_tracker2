import 'package:expense_tracker2/Provider/accountProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BalanceCardComponent extends ConsumerWidget {
  const BalanceCardComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider).account;

    final banks = account?.banks ?? [];

    if (banks.isEmpty) {
      return const Center(
        child: Text(
          'No bank accounts available.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      //height: 250,
      child: SingleChildScrollView(
        child: CarouselSlider(
          items: banks
              .map((bank) => BalanceCard(
                    accountName: account!.accountHolderName,
                    accountBalc:
                        bank.balc.toString(), // Safely convert to String
                    accountNo: bank.accountNumber
                        .substring(bank.accountNumber.length - 4),
                    bankName: bank.bankName, // Corrected variable name
                  ))
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.accountName,
    required this.accountBalc,
    required this.accountNo,
    required this.bankName, // Corrected parameter name
  });

  final String accountName;
  final String accountNo;
  final String accountBalc;
  final String bankName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Container(
          width: double.infinity, // Use the available width
          height: 160,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.blueAccent,
                Color.fromARGB(155, 114, 158, 255),
                Colors.blueAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Reduced font size
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  accountName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Reduced font size
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15), // Reduced height
                Text(
                  "**** **** **** $accountNo",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Reduced font size
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Text(
                  "Balance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Reduced font size
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      color: Colors.white,
                    ),
                    Text(
                      accountBalc,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14, // Reduced font size
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      bankName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14, // Reduced font size
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
