import 'dart:math';

import 'package:expense_tracker2/Modal/Provider/UserProvider.dart';
import 'package:expense_tracker2/View/Auth/CreateAccount/createPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAccountComponent extends ConsumerStatefulWidget {
  const CreateAccountComponent({super.key});

  @override
  ConsumerState<CreateAccountComponent> createState() =>
      _CreateAccountComponentState();
}

class _CreateAccountComponentState
    extends ConsumerState<CreateAccountComponent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final random = Random();
  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[A-Z|a-z]{2,}$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your date of birth';
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
              "Profile Name",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      validator: _validateFirstName,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      validator: _validateLastName,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: _validateEmail,
            ),
            const SizedBox(height: 20),
            // Date of Birth Field
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dobController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: "Date of Birth",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  validator: _validateDateOfBirth,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.watch(userNotifier).addProfile(
                      _firstNameController.text.toString(),
                      _lastNameController.text.toString(),
                      _emailController.text.toString(),
                      _dobController.text.toString(),
                      random.nextInt(9999).toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatepasswordPage(),
                    ),
                  );
                }
              },
              child: const Text(
                "Next",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
