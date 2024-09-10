import 'dart:async' show Timer;

import 'package:expense_tracker2/Modal/Provider/accountProvider.dart';
import 'package:expense_tracker2/Modal/User.dart';
import 'package:expense_tracker2/Modal/auth.dart';
import 'package:expense_tracker2/Modal/Provider/sessionProvider.dart';
import 'package:expense_tracker2/Modal/bank.dart';
import 'package:expense_tracker2/View/Auth/CreateAccount/namesAndDob.dart';
import 'package:expense_tracker2/View/Homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key});

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordHidden = true; // State variable for password visibility
  bool _isLoading = false; // State variable for showing the loader

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show the loader when form submission starts
      });

      String email = _emailController.text.toString();
      String password = _passwordController.text.toString();
      debugPrint("Email: $email \nPassword: $password");

      Map<String, dynamic>? loginSuccess = await authService.loginUser(
          email, password); // Await the login method
      Map<String, dynamic>? account = await authService.findAccount(email);
      // Update the session with user data
      if (loginSuccess != null && loginSuccess.isNotEmpty) {
        ref.read(sessionProvider).createSession(User(
            firstName: loginSuccess['firstName'],
            lastName: loginSuccess['lastName'],
            email: loginSuccess['email'],
            dob: loginSuccess['dob'],
            password: password));
        final userAccount = await authService.findAccount(email);
        ref.watch(accountProvider).account = Account.fromJson(userAccount!);
        debugPrint(
            "Account Holder:${ref.watch(accountProvider).account?.accountHolderName}");
        // Navigate to the next screen after a short delay
        Timer(const Duration(seconds: 2), () {
          setState(() {
            _isLoading = false; // Hide the loader when navigation starts
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        });
      } else {
        setState(() {
          _isLoading = false; // Hide the loader if login fails
        });

        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Login to your account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 122, 121, 121)
                            .withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Email:"),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 122, 121, 121)
                            .withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isPasswordHidden,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () => _submitForm(
                          ref), // Disable the button if loading is true
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                ),
                const SizedBox(height: 120),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account?"),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccount(),
                            ),
                          );
                        },
                        child: const Text(
                          " Sign up",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
