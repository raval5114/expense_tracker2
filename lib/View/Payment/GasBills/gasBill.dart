import 'package:expense_tracker2/Controller/Bills/searchIdComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GasBillView extends ConsumerStatefulWidget {
  const GasBillView({super.key});

  @override
  ConsumerState<GasBillView> createState() => _GasBillViewState();
}

class _GasBillViewState extends ConsumerState<GasBillView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Gas Bill",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: const SearchIdComponent(
        categoryIcon: Icons.gas_meter,
        categoryName: 'Gas Bill',
        searchId: 'ConsumerNo',
      ),
    );
  }
}
