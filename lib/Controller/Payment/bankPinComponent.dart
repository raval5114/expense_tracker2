import 'package:flutter/material.dart';

class BankPasswordComponent extends StatefulWidget {
  const BankPasswordComponent({super.key});

  @override
  State<BankPasswordComponent> createState() => _BankPasswordComponentState();
}

class _BankPasswordComponentState extends State<BankPasswordComponent> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  late final FocusNode _initialFocusNode;

  @override
  void initState() {
    super.initState();
    _initialFocusNode = _focusNodes[0]; // Focus on the first field by default
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_initialFocusNode);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _moveToNextField(int index) {
    if (index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      FocusScope.of(context).unfocus(); // Close the keyboard after last input
    }
  }

  void _submitPassword() {
    String password = _controllers.map((controller) => controller.text).join();
    print('UPI Password: $password');
    // Handle password submission logic here
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter the 6-digit bank-provided password to proceed with the transaction.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _moveToNextField(index);
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _submitPassword,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50), // Button height
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              'Submit PIN',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
