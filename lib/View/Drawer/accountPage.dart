import 'package:expense_tracker2/Modal/bank.dart';
import 'package:expense_tracker2/Provider/accountProvider.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  late List<Bank> banks;

  @override
  Widget build(BuildContext context) {
    // Watch the list of banks from the account provider
    banks = ref.watch(accountProvider).account!.banks;

    // Fetching user details from session provider
    String firstName = ref.watch(sessionProvider).user!.firstName;
    String lastName = ref.watch(sessionProvider).user!.lastName;
    String email = ref.watch(sessionProvider).user!.email;
    String dob = ref.watch(sessionProvider).user!.dob;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Avatar Section
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.blueAccent.withOpacity(0.3),
                child: const Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // User Information Cards
            _buildInfoCard("First Name", firstName),
            _buildInfoCard("Last Name", lastName),
            _buildInfoCard("Email", email, isEmail: true),
            _buildInfoCard("DOB", dob),

            const SizedBox(height: 20),

            // Section for displaying linked banks
            const Text(
              "Linked Banks",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),

            // If there are banks, display them, otherwise show a message
            banks.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true, // to allow the ListView inside ListView
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: banks.length,
                    itemBuilder: (context, index) {
                      return _buildBankCard(banks[index]);
                    },
                  )
                : const Center(
                    child: Text(
                      "No linked banks available.",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Function to build a reusable information card
  Widget _buildInfoCard(String label, String value, {bool isEmail = false}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$label:",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: isEmail ? 16 : 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function to build a bank card with labels for account number and balance
  Widget _buildBankCard(Bank bank) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank name
            Text(
              bank.bankName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Account number with "A/c No" label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "A/c No:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  bank.accountNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            // Balance with "Balance" label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Balance:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.currency_rupee_rounded,
                      size: 16,
                    ),
                    Text(
                      bank.balc.toStringAsFixed(
                          2), // Display balance with two decimal places
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
