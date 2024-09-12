import 'dart:async';

import 'package:expense_tracker2/Controller/Auth/addBankDetails.dart';
import 'package:expense_tracker2/Controller/Src/appLogo.dart';
import 'package:expense_tracker2/Provider/UserProvider.dart';
import 'package:expense_tracker2/View/Auth/SignUp/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Bankdetails extends ConsumerStatefulWidget {
  const Bankdetails({super.key});

  @override
  ConsumerState<Bankdetails> createState() => _BankdetailsState();
}

class _BankdetailsState extends ConsumerState<Bankdetails> {
  void routeToLoginPage() {
    Timer(const Duration(milliseconds: 90), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bank Details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () =>
                    {ref.watch(userNotifier).submitUser(), routeToLoginPage()},
                child: const Text(
                  "Skip for now",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                  ),
                )),
          )
        ],
      ),
      body: const Center(
        child: SizedBox(
          width: 520,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [AppLogo(), BankDetailsComponent()],
          ),
        ),
      ),
    );
  }
}
