import 'dart:async';
import 'package:expense_tracker2/Modal/bank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker2/Modal/auth.dart';

class AccountNotifier extends ChangeNotifier {
  Account? account;

  // Inject AuthService here
  final AuthService authService;

  AccountNotifier({required this.authService});

  void setAccount(Account account) {
    account = account;
    notifyListeners();
  }

  Future<void> addBank(Bank bank) async {
    if (account != null) {
      account!.banks.add(bank);
      notifyListeners();

      try {
        // Update account in the database
        await authService.insertAccount(account!);
      } catch (e) {
        debugPrint('Error updating account with new bank: $e');
      }
    }
  }

  Future<void> removeBank(Bank bank) async {
    if (account != null) {
      account!.banks.remove(bank);
      notifyListeners();

      try {
        // Update account in the database
        await authService.insertAccount(account!);
      } catch (e) {
        debugPrint('Error updating account after removing bank: $e');
      }
    }
  }

  Future<void> fetchAccount(String userId) async {
    try {
      final account = await authService.getAccount(userId);
      if (account != null) {
        setAccount(account);
      } else {
        debugPrint('No account found with accountId: $userId');
      }
    } catch (e) {
      debugPrint('Error fetching account: $e');
    }
  }
}

final accountProvider = ChangeNotifierProvider<AccountNotifier>((ref) {
  return AccountNotifier(authService: authService);
});
