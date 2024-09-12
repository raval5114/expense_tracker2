import 'package:expense_tracker2/Provider/UserProvider.dart';
import 'package:expense_tracker2/Provider/UserProvider.dart';
import 'package:expense_tracker2/View/Auth/CreateAccount/bankDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatepasswordComponent extends ConsumerStatefulWidget {
  const CreatepasswordComponent({super.key});

  @override
  ConsumerState<CreatepasswordComponent> createState() =>
      _CreatepasswordComponentState();
}

class _CreatepasswordComponentState
    extends ConsumerState<CreatepasswordComponent> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // State variables to toggle password visibility
  bool _isNewPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  // Controllers for the text fields

  // Validation messages
  String? _newPasswordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the tree
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _newPasswordError = null;
      _confirmPasswordError = null;

      String newPassword = _newPasswordController.text;
      String confirmPassword = _confirmPasswordController.text;

      // Validate New Password
      if (newPassword.isEmpty) {
        _newPasswordError = "New Password is required";
      } else if (newPassword.length < 8) {
        _newPasswordError = "Password must be at least 8 characters";
      }

      // Validate Confirm Password
      if (confirmPassword.isEmpty) {
        _confirmPasswordError = "Confirm Password is required";
      } else if (confirmPassword != newPassword) {
        _confirmPasswordError = "Passwords do not match";
      }

      // If both fields are valid, proceed with the submission
      if (_newPasswordError == null && _confirmPasswordError == null) {
        ref
            .watch(userNotifier)
            .addPassword(_confirmPasswordController.text.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Bankdetails(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Create a password",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 250,
          child: TextField(
            controller: _newPasswordController,
            obscureText: _isNewPasswordHidden,
            decoration: InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: _newPasswordError,
              suffixIcon: IconButton(
                icon: Icon(
                  _isNewPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isNewPasswordHidden =
                        !_isNewPasswordHidden; // Toggle state
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20), // Add some space between the fields
        SizedBox(
          width: 250,
          child: TextField(
            controller: _confirmPasswordController,
            obscureText:
                _isConfirmPasswordHidden, // Toggle confirm password visibility
            decoration: InputDecoration(
              labelText: "Confirm Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: _confirmPasswordError,
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordHidden =
                        !_isConfirmPasswordHidden; // Toggle state
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 30), // Add space before the submit button
        ElevatedButton(
          onPressed: _validateAndSubmit, // Validate inputs on submit
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Button color
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 15), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
          ),
          child: const Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
