import 'package:flutter/material.dart';
import 'package:sqliteapp/owner_list/view/owner_list_view.dart';
import 'package:sqliteapp/utils/navigation_utils.dart';

class OwnerView extends StatelessWidget {
  const OwnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owners'),
        leading: DrawerButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: const OwnerListView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          openAddOwnerView(context);
        },
        label: const Row(
          children: [Icon(Icons.add), Text('New Owner')],
        ),
      ),
    );
  }
}
