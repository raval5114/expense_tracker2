import 'package:expense_tracker2/Controller/Bills/searchIdComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WifiBillView extends ConsumerStatefulWidget {
  const WifiBillView({super.key});

  @override
  ConsumerState<WifiBillView> createState() => _WifiBillViewState();
}

class _WifiBillViewState extends ConsumerState<WifiBillView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Wifi Bill",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: const SearchIdComponent(
        categoryIcon: Icons.router,
        categoryName: 'Wifi Bill',
        searchId: 'ConsumerNo',
      ),
    );
  }
}
