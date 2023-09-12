import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/owner_list/models/owner.dart';
import 'package:sqliteapp/owner_list/view_models/owner_view_model.dart';

class EditOwnerView extends StatefulWidget {
  const EditOwnerView({super.key});

  @override
  State<EditOwnerView> createState() => _AddOwnerViewState();
}

class _AddOwnerViewState extends State<EditOwnerView> {
  final TextEditingController ownerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OwnerViewModel ownerViewModel = context.watch<OwnerViewModel>();
    Owner? editOwner = ownerViewModel.selectedOwner;

    final TextEditingController ownerController =
        TextEditingController(text: ownerViewModel.selectedOwner!.name);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Owner'),
        actions: [
          IconButton(
            onPressed: () {
              ownerViewModel.editOwner();
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
            controller: ownerController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
              labelText: 'Owner name',
            ),
            onChanged: (value) {
              editOwner?.name = value;
            },
          )
        ]),
      ),
    );
  }
}
