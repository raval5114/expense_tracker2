import 'package:expense_tracker2/Controller/Src/appLogo.dart';
import 'package:expense_tracker2/Modal/User.dart';
import 'package:expense_tracker2/Modal/auth.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
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
        // Load the transactions and create session
        ref
            .watch(expenseTrackerProvider)
            .loadData(email); // Changed to ref.read
        ref.read(sessionProvider).createSession(User(
              firstName: user['firstName'],
              lastName: user['lastname'],
              email: user['email'],
              dob: user['dob'],
              password: user['password'],
            ));
        _navigateToHome(context);
      } else {
        _navigateToLogin(context);
      }
    } else {
      _navigateToLogin(context);
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
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
