import 'package:expense_tracker2/Controller/Src/appLogo.dart';
import 'package:expense_tracker2/Modal/auth.dart';
import 'package:expense_tracker2/Modal/bank.dart';
import 'package:expense_tracker2/Provider/accountProvider.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:expense_tracker2/View/Auth/SignUp/loginPage.dart';
import 'package:expense_tracker2/View/Homepage/homepage.dart';
import 'package:expense_tracker2/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Modal/User.dart';

class SplashScreenCompoent extends ConsumerStatefulWidget {
  const SplashScreenCompoent({super.key});

  @override
  ConsumerState<SplashScreenCompoent> createState() =>
      _SplashScreenCompoentState();
}

class _SplashScreenCompoentState extends ConsumerState<SplashScreenCompoent> {
  bool _toGo = false;
  Future<void> _initApp(WidgetRef ref) async {
    try {
      //settingSp();
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString("email");
      final password = prefs.getString("password");
      if (email!.isNotEmpty && password!.isNotEmpty) {
        Map<String, dynamic>? user =
            await authService.loginUser(email, password);
        ref.read(sessionProvider).createSession(User(
            firstName: user?['firstName'],
            lastName: user?['lastName'],
            dob: user?['dob'],
            email: user?['email'],
            password: user?["password"]));
        ref.read(expenseTrackerProvider).loadData(email);
        final userAccount = await authService.findAccount(email);
        ref.watch(accountProvider).account = Account.fromJson(userAccount!);
        debugPrint(
            "Account Holder:${ref.watch(accountProvider).account?.accountHolderName}");
        _toGo = true;
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initApp(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppLogo(),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const AppLogo(),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
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
            return _toGo == true ? const MyHomePage() : const LoginPage();
          }
        },
      ),
    );
  }
}
