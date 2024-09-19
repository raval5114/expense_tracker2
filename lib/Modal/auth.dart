import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:expense_tracker2/Modal/bank.dart';
import 'package:expense_tracker2/Modal/const.dart';
import 'package:expense_tracker2/Modal/transaction.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AuthService {
  final String uri;
  final String dname;
  Db? _db;
  static const String collectionLoginName = "Users";
  static const String collectionAccountsName = "Accounts";

  AuthService({required this.uri, required this.dname});

  Future<void> connect() async {
    try {
      _db = await Db.create(uri);
      await _db?.open();
      debugPrint('Connected to MongoDB');
    } catch (e) {
      debugPrint("Error connecting to MongoDB: $e");
    }
  }

  Future<DbCollection> getCollection(String collectionName) async {
    if (_db == null || !_db!.isConnected) {
      await connect();
    }
    return _db!.collection(collectionName);
  }

  Future<Map<String, dynamic>?> findUser(String email) async {
    try {
      final collection = await getCollection(collectionLoginName);
      return await collection.findOne(where.eq('email', email));
    } catch (e) {
      debugPrint("Error finding user: $e");
      return null;
    }
  }

  Future<bool> authenticateUser(String email, String password) async {
    try {
      final user = await findUser(email);
      if (user == null) {
        debugPrint("User not found with email: $email");
        return false;
      }

      final hashedInputPassword = hashPassword(password);
      final storedPassword = user['password'] ?? '';

      debugPrint("Hashed input password: $hashedInputPassword");
      debugPrint("Stored password: $storedPassword");

      return hashedInputPassword == storedPassword;
    } catch (e) {
      debugPrint("Error authenticating user: $e");
      return false;
    }
  }

  Future<bool> registerUser(String firstName, String lastName, String email,
      String dob, String password) async {
    try {
      final existingUser = await findUser(email);
      if (existingUser != null) {
        debugPrint("User already exists with email: $email");
        return false;
      }
      final hashedPassword = hashPassword(password);
      debugPrint("Hashed Password during registration: $hashedPassword");

      final collection = await getCollection(collectionLoginName);
      await collection.insert({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'dob': dob,
        'password': hashedPassword,
      });
      debugPrint("User registered successfully with email: $email");
      return true;
    } catch (e) {
      debugPrint("Error registering user: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      final user = await findUser(email);
      if (user == null) {
        debugPrint("Authentication failed: User not found with email: $email");
        return null;
      }

      final hashedInputPassword = hashPassword(password);
      debugPrint("Hashed input password during login: $hashedInputPassword");
      debugPrint("Stored password in DB: ${user['password']}");

      if (hashedInputPassword == user['password']) {
        debugPrint("User logged in successfully: $email");
        return {
          'firstName': user['firstName'],
          'lastName': user['lastName'],
          'dob': user['dob'],
          'email': user['email'],
        };
      } else {
        debugPrint(
            "Authentication failed: Incorrect password for email: $email");
        return null;
      }
    } catch (e) {
      debugPrint("Error during login: $e");
      return null;
    }
  }

  String hashPassword(String password) {
    final trimmedPassword = password.trim();
    final bytes = utf8.encode(trimmedPassword);
    final hashPassword = sha256.convert(bytes);
    return hashPassword.toString();
  }

  // Insert an account
  Future<void> insertAccount(Account account) async {
    try {
      final collection = await getCollection(collectionAccountsName);
      final accountJson = account.tojson();
      await collection.insert(accountJson);
      debugPrint('Account inserted successfully');
    } catch (e) {
      debugPrint('Error inserting account: $e');
    }
  }

  Future<Account?> getAccount(String accountId) async {
    try {
      final collection = await getCollection(collectionAccountsName);
      final accountJson = await collection.findOne({'accountId': accountId});
      if (accountJson != null) {
        return Account.fromJson(accountJson);
      } else {
        debugPrint('No account found with accountId: $accountId');
        return null;
      }
    } catch (e) {
      debugPrint('Error retrieving account: $e');
      return null;
    }
  }

  // Update banks for an account
  Future<void> updateBanks(String email, List<Bank> updatedBanks) async {
    try {
      // Convert List<Bank> to List<Map<String, dynamic>> for MongoDB
      final collection = await getCollection(collectionAccountsName);
      List<Map<String, dynamic>> banksJson =
          updatedBanks.map((bank) => bank.tojson()).toList();

      // Update the banks array in the MongoDB document
      await collection.updateOne(
          where.eq('email', email), // Match the document by email
          modify.set(
              'banks', banksJson) // Replace the banks array with the new list
          );
      debugPrint("Banks updated successfully!");
    } catch (e) {
      debugPrint("Error during update: $e");
    }
  }

  Future<void> updateTransaction(
      String email, List<Transaction> transList) async {
    try {
      final collection = await getCollection(TRANSACTIONS);
      List<Map<String, dynamic>> transListToJson =
          transList.map((trans) => trans.toJson()).toList();
      await collection.updateOne(where.eq('email', email),
          modify.set('transactionList', transListToJson));
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<Map<String, dynamic>?> findAccount(String email) async {
    try {
      final collection = await getCollection(collectionAccountsName);
      final result = await collection.findOne(where.eq('email', email));

      // Check if result is null, and handle accordingly
      if (result == null) {
        debugPrint('No account found for email: $email');
        return null;
      }

      return result;
    } catch (e) {
      debugPrint('Error finding account: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> findAccountByMobileNo(String mobileNo) async {
    try {
      final collection = await getCollection(collectionAccountsName);
      final result = await collection.findOne(where.eq('mobileNo', mobileNo));

      // Check if result is null, and handle accordingly
      if (result == null) {
        debugPrint('No account found for mobile number: $mobileNo');
        return null;
      }

      return result;
    } catch (e) {
      debugPrint('Error finding account by mobile number: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> findAndLoadTransaction(String email) async {
    try {
      final collection = await getCollection('Transactions');
      final transaction = await collection.findOne(where.eq('email', email));

      if (transaction != null) {
        return {
          'email': transaction['email'],
          'currentBalc': transaction['currentBalc'],
          'transactionList': transaction['transactionList'],
        };
      }
    } catch (e) {
      debugPrint('Error fetching transaction: $e');
    }

    Future<void> updateTransaction(String email) async {
      final collection = await getCollection(TRANSACTIONS);
      //finsh the query
    }

    // Return null if no transaction is found or if an error occurs
    return null;
  }

  Future<void> insertMultipleRecords(List<Map<String, dynamic>> records) async {
    try {
      final collection = await getCollection(ELECTRICITY_BILL_COLLECTION);
      await collection.insertAll(records);
      debugPrint('Multiple records inserted successfully');
    } catch (e) {
      debugPrint('Error inserting multiple records: $e');
    }
  }
}

final authService = AuthService(uri: MONGO_URL, dname: 'Expensetracker');
