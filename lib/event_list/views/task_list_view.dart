import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/event_list/view_models/events_view_model.dart';
import 'package:sqliteapp/event_list/views/edit_event_view.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    EventViewModel eventViewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text(eventViewModel.selectedEvent!.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: InkWell(
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditEventView()));

                },
                child: const Icon(Icons.edit)),
          ),
        ],
      ),
      body: const Center(
        child: Text('Tasks'),
      ),
    );
  }
}
