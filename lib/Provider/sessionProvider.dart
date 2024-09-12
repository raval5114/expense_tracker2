import 'package:expense_tracker2/Modal/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession extends ChangeNotifier {
  User? user;

  void createSession(User newUser) async {
    final SharedPreferencesWithCache prefs =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{'email', 'password'}),
    );
    user = newUser;
    prefs.setString('email', user!.email);
    prefs.setString('password', user!.password);
    debugPrint("Email: ${prefs.getString('email')}");
    debugPrint('Password: ${prefs.getString('password')}');
    notifyListeners();
  }

  void destroySession() async {
    final SharedPreferencesWithCache prefs =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{'email', 'password'}),
    );
    user = null;
    prefs.remove('email');
    prefs.remove('password');
    notifyListeners();
  }
}

final sessionProvider =
    ChangeNotifierProvider<UserSession>((ref) => UserSession());
