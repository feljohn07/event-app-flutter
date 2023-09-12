import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/owner_list/components/owner_item.dart';
import 'package:sqliteapp/owner_list/models/owner.dart';
import 'package:sqliteapp/owner_list/view_models/owner_view_model.dart';
import 'package:sqliteapp/utils/navigation_utils.dart';

class OwnerListView extends StatelessWidget {
  const OwnerListView({super.key});

  @override
  Widget build(BuildContext context) {
    OwnerViewModel ownerViewModel = context.watch<OwnerViewModel>();
    return StreamBuilder(
      stream: ownerViewModel.getOwners(),
      builder: (context, snapshot) {
        if (snapshot.data?.isNotEmpty ?? false) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return OwnerListItem(
                owner: snapshot.data![index],
                onTap: () {
                  openEditOwnerView(context);
                  ownerViewModel.setSelectedOwner(snapshot.data![index]);
                },
                onTapDelete: (Owner owner) {
                  ownerViewModel.deleteOwner(owner.id);
                },
              );
            },
          );
        } else {
          return const Center(
            child: Text('Click + to add new owner.'),
          );
        }
      },
    );
  }
}
