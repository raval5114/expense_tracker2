import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:expense_tracker2/View/Auth/SignUp/loginPage.dart';
import 'package:expense_tracker2/View/Drawer/accountPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerComponent extends ConsumerWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String FirstName = ref.watch(sessionProvider).user!.firstName;
    String lastName = ref.watch(sessionProvider).user!.lastName;
    String email = ref.watch(sessionProvider).user!.email;
    final user = ref.watch(sessionProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  accountName: Text(
                    "$FirstName $lastName",
                    style: const TextStyle(fontSize: 18),
                  ),
                  currentAccountPictureSize: const Size.square(40),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(FirstName[0],
                        style: const TextStyle(
                            fontSize: 30.0, color: Colors.blue)),
                  ),
                  accountEmail: Text(email))),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountPage(),
                  ));
            },
            child: const ListTile(
              leading: Icon(size: 32, Icons.person),
              title: Text(
                "My account",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(size: 32, Icons.policy),
            title: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const ListTile(
            leading: Icon(size: 32, Icons.settings),
            title: Text(
              "Setting",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const ListTile(
            leading: Icon(size: 32, Icons.question_mark),
            title: Text(
              "Help Center",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const ListTile(
            leading: Icon(size: 32, Icons.call),
            title: Text(
              "Contact",
              style: TextStyle(fontSize: 20),
            ),
          ),
          InkWell(
            onTap: () {
              user.createSession(ref.watch(sessionProvider).user!);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
            child: const ListTile(
              leading: Icon(size: 32, Icons.logout),
              title: Text(
                "Log out",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
