import 'dart:async';
import 'package:expense_tracker2/Modal/bank.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
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

  //finding specific value from specific place Bank
  int findIndexByNameFromBank(List<Object> bank, String valTofind) {
    for (int i = 0; i < bank.length; i++) {
      if (bank[i] is Bank) {
        Bank newBank = bank[i] as Bank;
        if (newBank.bankName == valTofind) {
          return i;
        }
      }
    }

    return -1;
  }

  //finding specific value from specific place Account
  int findIndexByNameFromAccount(List<Object> account, String valTofind) {
    for (int i = 0; i < account.length; i++) {
      if (account[i] is Bank) {
        Bank newBank = account[i] as Bank;
        if (newBank.bankName == valTofind) {
          return i;
        }
      }
    }

    return -1;
  }

  void billPaymentWithMobileNumber(
      WidgetRef ref, String mobileNumber, String amount) async {
    try {
      // Find the user's account using the provided mobile number
      final user = await authService.findAccountByMobileNo(mobileNumber);
      if (user == null) {
        debugPrint('User account not found');
        return; // Stop execution if no account is found
      }

      // Set the account data into the account provider
      ref.watch(accountProvider).account = Account.fromJson(user);

      // Debug output before performing the transaction
      debugPrint('\nBefore Transaction');
      debugPrint(
          'Bank balance: ${ref.watch(accountProvider).account?.banks[1].balc}');
      debugPrint('Deducting amount: $amount');

      // Parse the amount to an integer
      final parsedAmount = int.tryParse(amount);
      if (parsedAmount == null) {
        debugPrint('Invalid amount format');
        return; // Stop execution if the amount is not valid
      }

      // Check if the user has sufficient balance for the transaction
      final bank = ref.watch(accountProvider).account?.banks[1];
      if (bank == null) {
        debugPrint('Bank account not found');
        return; // Stop execution if no bank account is found
      }

      if (bank.balc > parsedAmount) {
        // Perform the deduction
        bank.balc -= parsedAmount;

        // Output after the transaction
        debugPrint('\nAfter Transaction');
        debugPrint('Updated Bank balance: ${bank.balc}');

        // Update the banks in the database
        await authService.updateBanks(
          ref.watch(accountProvider).account!.email!,
          ref.watch(accountProvider).account!.banks,
        );
      } else {
        debugPrint('Insufficient Balance');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void billPaymentWithCard(WidgetRef ref, String dropDownDefaultItem,
      dynamic cvvController, dynamic amountController, String email) async {
    try {
      // Fetch the user account based on email
      final userAccount = await authService.findAccount(email);

      if (userAccount == null) {
        debugPrint('User account not found');
        return; // Stop execution if no account is found
      }

      // Set the account in the provider
      ref.read(accountProvider).account = Account.fromJson(userAccount);

      // Get the list of banks
      List<Bank>? bankList = ref.read(accountProvider).account?.banks;

      if (bankList == null || bankList.isEmpty) {
        debugPrint('No banks found for the account');
        return; // Stop execution if no banks are found
      }

      // Find the bank by bankName
      int bankIndex = findIndexByNameFromBank(
          bankList as List<Object>, dropDownDefaultItem);
      if (bankIndex < 0) {
        debugPrint('Bank not found in the list');
        return;
      }

      // Output before the transaction
      debugPrint('\nBefore Transaction');
      debugPrint('Bank balance: ${bankList[bankIndex].balc}');
      debugPrint('Deducting amount: $amountController');

      // CVV validation
      if (cvvController == '123') {
        if (bankList[bankIndex].balc > int.parse(amountController)) {
          bankList[bankIndex].balc -= int.parse(amountController);
          debugPrint('\nAfter Transaction');
          debugPrint('Updated Bank balance: ${bankList[bankIndex].balc}');
          authService.updateBanks("hariraval81@gmail.com", bankList);
        } else {
          debugPrint('insufficient Balance');
        }
      } else {
        debugPrint('Invalid CVV entered');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }

  void transferEvent(WidgetRef ref, String amount) {
    List<Bank>? currentUser = ref.watch(accountProvider).account?.banks;
    String? email = ref.watch(sessionProvider).user?.email;
    debugPrint('Before Transaction');
    debugPrint('Balance: ${currentUser![1].balc}');
    debugPrint('Deducted amount: ${amount}');
    debugPrint('\n');
    currentUser![1].balc -= int.parse(amount);
    authService.updateBanks(email!, currentUser);
    debugPrint("After Transaction");
    debugPrint('Balance: ${currentUser[1].balc}');
    debugPrint('Deducted amount: ${amount}');
  }
}

final accountProvider = ChangeNotifierProvider<AccountNotifier>((ref) {
  return AccountNotifier(authService: authService);
});
