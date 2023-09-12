import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/owner_list/models/owner.dart';
import 'package:sqliteapp/owner_list/view_models/owner_view_model.dart';

class AddOwnerView extends StatefulWidget {
  const AddOwnerView({super.key});

  @override
  State<AddOwnerView> createState() => _AddOwnerViewState();
}

class _AddOwnerViewState extends State<AddOwnerView> {
  @override
  Widget build(BuildContext context) {
    OwnerViewModel ownerViewModel = context.watch<OwnerViewModel>();
    Owner? addingOwner = ownerViewModel.addingOwner;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner View'),
        actions: [
          IconButton(
            onPressed: () {
              ownerViewModel.addOwner();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Owner name'
            ),
            onChanged: (value) {
              addingOwner?.name = value;
            },
          )
        ]),
      ),
    );
  }
}
