import 'package:expense_tracker2/Controller/Bills/searchIdComponent.dart';
import 'package:expense_tracker2/Modal/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ElectricityBillView extends ConsumerStatefulWidget {
  const ElectricityBillView({super.key});

  @override
  ConsumerState<ElectricityBillView> createState() =>
      _ElectricityBillViewState();
}

class _ElectricityBillViewState extends ConsumerState<ElectricityBillView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Electricity Bill",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: const SearchIdComponent(
        categoryIcon: Icons.lightbulb_sharp,
        categoryName: 'Electricity',
        searchId: 'ConsumerNo',
        collectionName: ELECTRICITY_BILL_COLLECTION,
      ),
    );
  }
}
