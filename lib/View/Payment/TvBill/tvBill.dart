import 'package:expense_tracker2/Controller/Bills/searchIdComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TvBillView extends ConsumerStatefulWidget {
  const TvBillView({super.key});

  @override
  ConsumerState<TvBillView> createState() => _TvBillViewState();
}

class _TvBillViewState extends ConsumerState<TvBillView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Television Bill",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: const SearchIdComponent(
        categoryIcon: Icons.router,
        categoryName: 'Television Bill',
        searchId: 'ConsumerNo',
        collectionName: '',
      ),
    );
  }
}
