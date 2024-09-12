import 'package:expense_tracker2/Provider/accountProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceCardComponent extends ConsumerWidget {
  const BalanceCardComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider).account;

    // Handle potential null values for account and banks
    final banks = account?.banks ?? [];

    // If banks list is empty, you might want to show a placeholder
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
      height: 250, // Set a fixed height if needed
      child: FlutterCarousel.builder(
        itemCount: banks.length,
        itemBuilder: (context, index, realIndex) => BalanceCard(
          accountName: account!.accountHolderName,
          accountBalc: banks[index].balc.toString(), // Safely convert to String
          accountNo: banks[index]
              .accountNumber
              .substring(banks[index].accountNumber.length - 4),
          bankName: banks[index].bankName, // Corrected variable name
        ),
        options: CarouselOptions(autoPlay: true),
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
    // Make the card responsive by using MediaQuery or LayoutBuilder
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Container(
          width: 420,
          height: 250,
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
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  accountName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 19),
                Text(
                  "**** **** **** $accountNo",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Balance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
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
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      bankName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
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
