import 'package:expense_tracker2/Modal/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends ChangeNotifier {
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String dob;
  late String userId;
  void addProfile(String firstName, String lastName, String email, String dob,
      String usserId) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.dob = dob;
    this.userId = usserId;
  }

  void addPassword(String password) {
    this.password = password;
  }

  void submitUser() {
    authService.registerUser(
      firstName,
      lastName,
      email,
      dob,
      password,
    );
  }
}

final userNotifier =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());
