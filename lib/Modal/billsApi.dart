import 'package:expense_tracker2/Modal/ElectricityBill.dart';
import 'package:expense_tracker2/Modal/const.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDbService {
  final String uri;
  final String dbName;
  Db? _db;

  MongoDbService({required this.uri, required this.dbName});

  Future<void> connect() async {
    try {
      _db = await Db.create(uri);
      await _db?.open();
      print('Connection established');
    } catch (e) {
      print("Error connecting to database: $e");
    }
  }

  Future<void> close() async {
    try {
      await _db?.close();
      print("Connection closed");
    } catch (e) {
      print("Error closing the database: $e");
    }
  }

  Future<void> insertRecord(
      String collectionName, Map<String, dynamic> document) async {
    try {
      var collection = _db?.collection(collectionName);
      await collection?.insert(document);
      print('Record inserted successfully');
    } catch (e) {
      print("Error inserting record: $e");
    }
  }

  Future<Map<String, dynamic>?> getRecord(
      String collectionName, String id) async {
    try {
      var collection = _db?.collection(collectionName);
      var record = await collection?.findOne(where.id(ObjectId.parse(id)));
      return record;
    } catch (e) {
      print("Error fetching record: $e");
      return null;
    }
  }

  Future<void> updateBillStatus(
      String collectionName, String consumerNumber, String newStatus) async {
    try {
      var collection = _db?.collection(collectionName);
      await collection?.update(where.eq('consumerNumber', consumerNumber),
          modify.set('status', newStatus));
      print('Bill status updated');
    } catch (e) {
      print("Error updating bill status: $e");
    }
  }

  Future<Bill?> retrieveRecord(
      String collectionName, String consumerNumber) async {
    try {
      var collection = _db?.collection(collectionName);
      var records =
          await collection?.findOne(where.eq('consumerNumber', consumerNumber));
      debugPrint(records?['consumerNumber']);
      return Bill.fromJson(records!);
    } catch (e) {
      print("Error retrieving record: $e");
      return null;
    }
  }

  Future<void> insertMultipleRecords(List<Map<String, dynamic>> records) async {
    try {
      var collection = _db?.collection(ELECTRICITY_BILL_COLLECTION);
      await collection?.insertAll(records);
      debugPrint('Multiple records inserted successfully');
    } catch (e) {
      debugPrint('Error inserting multiple records: $e');
    }
  }
}

final bilsAndStuffService = MongoDbService(
  uri: MONGO_URL_FOR_BILL,
  dbName: 'BillsandStuff',
);
