import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/task_list/components/task_list_item.dart';
import 'package:sqliteapp/task_list/models/task.dart';
import 'package:sqliteapp/event_list/view_models/events_view_model.dart';
import 'package:sqliteapp/task_list/view_models/task_view_model.dart';
import 'package:sqliteapp/utils/confirm.dart';
import 'package:sqliteapp/utils/navigation_utils.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    TaskViewModel taskViewModel = context.watch();
    EventViewModel eventViewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text('${eventViewModel.selectedEvent!.name} Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                openEventEditView(context);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: StreamBuilder<List<Task>>(
          stream: taskViewModel.getTasks(eventViewModel.selectedEvent!),
          builder: (context, snapshot) {
            if (snapshot.data?.isNotEmpty ?? false) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  return TaskListItem(
                    task: snapshot.data![index],
                    onTap: () {
                      taskViewModel.setSelectedTask(snapshot.data![index]);
                      opentEditTaskView(context);
                    },
                    onTapDelete: (Task task) {
                      confirmDelete(
                        context,
                        'You will delete `${task.text}`',
                        () {
                          taskViewModel.deleteTask(task.id);
                        },
                      );
                    },
                    onToggle: (bool? value) {
                      print(value);
                      taskViewModel.toggleTaskStatus(snapshot.data![index]);
                    },
                  );
                },
              );
            } else {
              return const Center(
                  child: Text('Press the + icon to add an event'));
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            opentAddTaskView(context);
          },
          label: const Row(
            children: [Icon(Icons.add), Text('New Task')],
          )),
    );
  }
}
