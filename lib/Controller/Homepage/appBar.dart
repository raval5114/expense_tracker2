import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewAppBar extends ConsumerStatefulWidget {
  const NewAppBar({super.key});

  @override
  ConsumerState<NewAppBar> createState() => _NewAppBarState();
}

class _NewAppBarState extends ConsumerState<NewAppBar> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(sessionProvider).user;
    final lastName =
        user?.lastName ?? 'User'; // Use 'User' as default if lastName is null

    return SliverAppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 22,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Namastae",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          ),
          Text("Mr $lastName")
        ],
      ),
      expandedHeight: 45,
    );
  }
}
