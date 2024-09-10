import 'package:expense_tracker2/Controller/Auth/loginComponent.dart';
import 'package:expense_tracker2/Controller/appLogo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 520,
          child: Column(
            children: [AppLogo(), LoginComponent()],
          ),
        ),
      ),
    );
  }
}
