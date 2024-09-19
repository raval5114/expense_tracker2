// ignore: file_names
import 'package:expense_tracker2/Provider/accountProvider.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:expense_tracker2/View/Payment/bankPin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayWithCards extends ConsumerStatefulWidget {
  const PayWithCards({super.key});

  @override
  ConsumerState<PayWithCards> createState() => _PayWithCardsState();
}

class _PayWithCardsState extends ConsumerState<PayWithCards> {
  final _formKey = GlobalKey<FormState>();
  var _dropDownDefaultItem = 'SBI';
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    cvvController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Select Bank:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _dropDownDefaultItem,
              icon: const Icon(Icons.arrow_downward_sharp, size: 28),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'SBI', child: Text('State Bank Of India')),
                DropdownMenuItem(value: 'BOI', child: Text('Bank of India')),
                DropdownMenuItem(value: 'Axis Bank', child: Text('Axis Bank')),
              ],
              onChanged: (String? value) {
                setState(() {
                  _dropDownDefaultItem = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a bank';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter CVV:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cvvController,
              obscureText: true,
              maxLength: 3, // CVV is typically 3 digits
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                label: Text("CVV"),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your CVV';
                } else if (value.length != 3) {
                  return 'CVV must be 3 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter Amount:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee),
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                } else if (double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => BankPassword(),
                    //     ));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankPassword(
                            state: 'email',
                            defaultDropDownValue: _dropDownDefaultItem,
                            cvv: cvvController.text.toString(),
                            amount: _amountController.text.toString(),
                            mobileNo: '',
                            email: ref.watch(sessionProvider).user!.email,
                          ),
                        ));
                  }
                },
                child: const Text(
                  "Pay",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PayWithNumbers extends ConsumerStatefulWidget {
  const PayWithNumbers({Key? key}) : super(key: key);

  @override
  ConsumerState<PayWithNumbers> createState() => _PayWithNumbersState();
}

class _PayWithNumbersState extends ConsumerState<PayWithNumbers> {
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileNumberController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Mobile Number:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: mobileNumberController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10), // limit to 10 digits
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Mobile Number',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your mobile number';
                } else if (value.length != 10) {
                  return 'Mobile number must be 10 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter Amount:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee),
                hintText: 'Amount',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                } else if (double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Make sure accountProvider is correctly defined and accessible
                    // final AccountProvider = ref.read(accountProvider);
                    // AccountProvider.billPaymentWithMobileNumber(
                    //     ref,
                    //     mobileNumberController.text.toString(),
                    //     amountController.text.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankPassword(
                            state: 'mobileNumber',
                            defaultDropDownValue: '',
                            cvv: '',
                            amount: amountController.text.toString(),
                            mobileNo: mobileNumberController.text.toString(),
                            email: ref.watch(sessionProvider).user!.email,
                          ),
                        ));
                  }
                },
                child: const Text(
                  "Pay",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
