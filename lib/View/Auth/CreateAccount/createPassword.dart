import 'package:expense_tracker2/Controller/Auth/createPasswordComponent.dart';
import 'package:expense_tracker2/Controller/appLogo.dart';
import 'package:flutter/material.dart';

class CreatepasswordPage extends StatefulWidget {
  const CreatepasswordPage({super.key});

  @override
  State<CreatepasswordPage> createState() => _CreatepasswordPageState();
}

class _CreatepasswordPageState extends State<CreatepasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: const Center(
          child: Column(
        children: [AppLogo(), CreatepasswordComponent()],
      )),
    );
  }
}
