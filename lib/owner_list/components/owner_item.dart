import 'package:flutter/material.dart';
import 'package:sqliteapp/owner_list/models/owner.dart';

class OwnerListItem extends StatelessWidget {
  final Owner owner;
  final Function onTap;
  final Function onTapDelete;

  const OwnerListItem(
      {super.key,
      required this.owner,
      required this.onTap,
      required this.onTapDelete,});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => onTap(),
      child: Row(children: [
        Expanded(
          child: ListTile(
            title: Text(owner.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onTapDelete(owner),
            ),
          ),
        ),
      ]),
    );
  }
}
