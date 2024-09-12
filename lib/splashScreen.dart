import 'package:expense_tracker2/Controller/Src/appLogo.dart';
import 'package:expense_tracker2/Provider/accountProvider.dart';
import 'package:expense_tracker2/Modal/User.dart';
import 'package:expense_tracker2/Modal/auth.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:expense_tracker2/Modal/bank.dart';
import 'package:expense_tracker2/View/Auth/SignUp/loginPage.dart';
import 'package:expense_tracker2/View/Homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  Future<void> _initializeApp(BuildContext context, WidgetRef ref) async {
    try {
      await getPrefEmailAndPassword(context, ref);
    } catch (e) {
      debugPrint("Error during initialization: $e");
      return Future.error(e);
    }
  }

  Future<void> getPrefEmailAndPassword(
      BuildContext context, WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (email != null && password != null) {
      // Await the loginUser method to get the actual result
      final Map<String, dynamic>? user =
          await authService.loginUser(email, password);
      if (user != null) {
        // Proceed with creating the session and navigating to the home page
        ref.watch(sessionProvider).createSession(User(
              firstName: user['firstName'],
              lastName: user['lastname'],
              email: user['email'],
              dob: user['dob'],
              password: user['password'],
            ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
        debugPrint('UserID:${user['userId']}');
      } else {
        // If loginUser returns null (e.g., wrong credentials), navigate to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } else {
      // If email or password is not found in SharedPreferences, navigate to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeApp(context, ref),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppLogo(),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const AppLogo(),
                  const SizedBox(height: 20),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              );
            } else {
              return const MyHomePage();
            }
          },
        ),
      ),
    );
  }
}
