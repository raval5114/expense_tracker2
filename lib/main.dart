import 'package:expense_tracker2/Modal/billsApi.dart';
import 'package:expense_tracker2/View/IncomeAndExpenses/updateTransactionTesting.dart';
import 'package:expense_tracker2/View/paymentTestesing.dart';
import 'package:expense_tracker2/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
  bilsAndStuffService.connect();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueAccent),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
