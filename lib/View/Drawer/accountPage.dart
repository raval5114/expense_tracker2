import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Accountpage extends ConsumerStatefulWidget {
  const Accountpage({super.key});

  @override
  ConsumerState<Accountpage> createState() => _AccountpageState();
}

class _AccountpageState extends ConsumerState<Accountpage> {
  @override
  Widget build(BuildContext context) {
    String FirstName = ref.watch(sessionProvider).user!.firstName;
    String lastName = ref.watch(sessionProvider).user!.lastName;
    String email = ref.watch(sessionProvider).user!.email;
    String dob = ref.watch(sessionProvider).user!.dob;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Expanded(
          child: ListView(
        children: [
          const Expanded(
              child: Column(
            children: [
              CircleAvatar(radius: 80, child: Icon(size: 120, Icons.person)),
            ],
          )),
          const SizedBox(
            height: 40,
          ),
          Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "First Name:",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  FirstName,
                  style: const TextStyle(fontSize: 32),
                )
              ],
            ),
          ),
          Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Last Name:",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  lastName,
                  style: const TextStyle(fontSize: 32),
                )
              ],
            ),
          ),
          Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Email:",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  "$email",
                  style: const TextStyle(fontSize: 22),
                )
              ],
            ),
          ),
          Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "DOB:",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  dob,
                  style: const TextStyle(fontSize: 32),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
