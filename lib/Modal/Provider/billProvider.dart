import 'package:expense_tracker2/Modal/ElectricityBill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillProvider extends ChangeNotifier {
  Bill? bill;

  BillProvider();

  void addBill(Bill newBill) {
    bill = newBill;
    notifyListeners();
  }
}

final billProvider =
    ChangeNotifierProvider<BillProvider>((ref) => BillProvider());
