import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/event_list/view_models/events_view_model.dart';
import 'package:sqliteapp/task_list/views/event_task_list_view.dart';
import 'package:sqliteapp/utils/confirm.dart';
import 'package:sqliteapp/utils/navigation_utils.dart';
import '../models/event.dart';
import 'package:sqliteapp/event_list/components/event_item.dart';

/// Generates and returns a widget with list of events stored in the Box.
// ignore: must_be_immutable
class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    EventViewModel eventViewModel = context.watch();

    return StreamBuilder<List<Event>>(
        stream: eventViewModel.searchEvents(),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: (context, index) {
                return EventListItem(
                    event: snapshot.data![index],
                    onTap: () {
                      eventViewModel.setSelectedEvent(snapshot.data![index]);
                      opentTaskListView(context);
                    },
                    onTapDelete: (Event event) {
                      confirmDelete(
                        context,
                        'You will delete ${event.name}',
                        () {
                          Navigator.of(context).pop();
                          eventViewModel.deleteEvent(event.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Deleted')));
                        },
                      );
                    });
              },
            );
          } else {
            return const Center(
                child: Text('Press the + icon to add an event'));
          }
        });
  }
}
