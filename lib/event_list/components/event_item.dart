import 'package:flutter/material.dart';
import 'package:sqliteapp/event_list/models/event.dart';

class EventListItem extends StatelessWidget {
  final Event event;
  final Function onTap;
  final Function onTapDelete;

  const EventListItem({super.key, required this.event, required this.onTap, required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(children: [
        Expanded(
          child: ListTile(
            title: Text(event.name),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(event.date?.toString() ?? ''),
              Text(event.description ?? ''),
              Text(event.location ?? ''),
            ]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onTapDelete(event),
            ),
            isThreeLine: true,
          ),
        ),
      ]),
    );
  }
}