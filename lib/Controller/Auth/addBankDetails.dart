import 'package:flutter/material.dart';

class BankDetailsComponent extends StatefulWidget {
  const BankDetailsComponent({super.key});

  @override
  State<BankDetailsComponent> createState() => _BankDetailsComponentState();
}

final _formKey = GlobalKey<FormState>();

final TextEditingController accountNoController = TextEditingController();
final TextEditingController bankNameController = TextEditingController();
final TextEditingController ifscCodeController = TextEditingController();

class _BankDetailsComponentState extends State<BankDetailsComponent> {
  String? _validateAccountNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your account number';
    }
    return null;
  }

  String? _validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your bank name';
    }
    return null;
  }

  String? _validateIfscCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your IFSC code';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add a bank account",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: accountNoController,
              decoration: const InputDecoration(
                labelText: "Account Number",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: _validateAccountNo,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: bankNameController,
              decoration: const InputDecoration(
                labelText: "Bank Name",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: _validateBankName,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ifscCodeController,
              decoration: const InputDecoration(
                labelText: "IFSC Code",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: _validateIfscCode,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text(
                "Submit",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
