import 'package:expense_tracker2/Controller/Payment/searchIdComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchId extends ConsumerStatefulWidget {
  const SearchId({super.key});

  @override
  ConsumerState<SearchId> createState() => _SearchIdState();
}

class _SearchIdState extends ConsumerState<SearchId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Pay to",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: const SearchIdComponent(
        categoryIcon: Icons.lightbulb_sharp,
        categoryName: 'Electricity',
        searchId: 'ConsumerNo',
      ),
    );
  }
}
