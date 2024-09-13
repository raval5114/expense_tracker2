import 'package:expense_tracker2/Controller/Features/Homepage/actionCard.dart';
import 'package:expense_tracker2/View/Payment/bankPin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PayWithCards extends StatefulWidget {
  const PayWithCards({super.key});

  @override
  State<PayWithCards> createState() => _PayWithCardsState();
}

class _PayWithCardsState extends State<PayWithCards> {
  final _formKey = GlobalKey<FormState>();
  var _dropDownDefaultItem = 'SBI';
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _cvvController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: BalanceCard(
                accountName: "Hari Raval",
                accountBalc: '50000',
                accountNo: '5114',
                bankName: 'SBI'),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Account Number:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonFormField<String>(
              value: _dropDownDefaultItem,
              icon: const Icon(
                Icons.arrow_downward_sharp,
                size: 32,
              ),
              decoration: const InputDecoration(border: OutlineInputBorder()),
              iconEnabledColor: Colors.blueAccent,
              style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              dropdownColor: Colors.white,
              items: const [
                DropdownMenuItem(
                    value: 'SBI', child: Text('State Bank Of India')),
                DropdownMenuItem(value: 'BOI', child: Text('Bank of India')),
                DropdownMenuItem(value: 'AXIS', child: Text('Axis Bank')),
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
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 100,
              child: TextFormField(
                controller: _cvvController,
                obscureText: true,
                maxLength: 3, // CVV is typically 3 digits
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  label: Text("CVV"),
                  border: OutlineInputBorder(),
                  counterText: "", // Hides the character counter
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 100,
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  prefix: Icon(Icons.currency_rupee),
                  label: Text("Amount"),
                  border: OutlineInputBorder(),
                  counterText: "", // Hides the character counter
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
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BankPassword(),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Pay",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PayWithNumbers extends StatefulWidget {
  const PayWithNumbers({super.key});

  @override
  State<PayWithNumbers> createState() => _PayWithNumbersState();
}

class _PayWithNumbersState extends State<PayWithNumbers> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Mobile Number:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _mobileNumberController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10) // limit to 10 digits
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                prefix: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(),
                hintText: 'Amount',
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigate to the BankPassword screen after validation
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BankPassword(),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Pay",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
