import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/event_list/view_models/events_view_model.dart';
import 'package:sqliteapp/event_list/view_models/object_box_view_model.dart';
import 'package:sqliteapp/event_list/views/event_list_view.dart';
import 'package:sqliteapp/utils/navigation_utils.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    EventViewModel eventViewModel = context.watch<EventViewModel>();
    ObjectBoxViewModel objectBoxViewModel = context.watch<ObjectBoxViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Manager'),
        leading: DrawerButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                objectBoxViewModel.loadData();
                eventViewModel.setEventCount();
              },
              icon: const Icon(Icons.download)),
          IconButton(
              onPressed: () {
                objectBoxViewModel.deleteAll();
                eventViewModel.setEventCount();
              },
              icon: const Icon(Icons.delete_sweep)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (text) {
                setState(() {
                  eventViewModel.setSearchQuery(text);
                });
              },
              onSubmitted: (value) {
                setState(() {
                  eventViewModel.setSearchQuery(value);
                });
              },
            ),
            const Expanded(child: EventList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          opentAddEventView(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
