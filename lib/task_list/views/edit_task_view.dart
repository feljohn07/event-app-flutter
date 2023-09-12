import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqliteapp/owner_list/models/owner.dart';
import 'package:sqliteapp/task_list/models/task.dart';
import 'package:sqliteapp/owner_list/view_models/owner_view_model.dart';
import 'package:sqliteapp/task_list/view_models/task_view_model.dart';
import 'package:sqliteapp/utils/snackbar.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key});

  @override
  State<EditTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<EditTaskView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TaskViewModel taskViewModel = context.watch<TaskViewModel>();
    OwnerViewModel ownerViewModel = context.watch<OwnerViewModel>();
    Task editTask = taskViewModel.selectedTask;

    // set selectedOwner to null to prevent garbage from last use.
    taskViewModel.setSelectedOwner(null);

    TextEditingController taskController =
        TextEditingController(text: editTask.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
              onPressed: () async {
                taskViewModel.editTask();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: taskController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.task),
                    border: OutlineInputBorder(),
                    labelText: 'Task note',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Task note required.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    editTask.text = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<List<Owner>>(
                  stream: ownerViewModel.getOwners(),
                  builder: (context, snapshot) {
                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.person),
                        border: const OutlineInputBorder(),
                        hintText: editTask.owner.target?.name
                      ),
                      icon: (taskViewModel.selectedOwner != null)
                          ? InkWell(
                              child: const Icon(Icons.add_outlined),
                              onTap: () {
                                showSnackBar(context, 'Add new owner.');
                              },
                            )
                          : null,
                      items: snapshot.data!.map((value) {
                        return DropdownMenuItem(
                          value: value.id,
                          child: Text(value.name),
                          onTap: () {
                            taskViewModel.setSelectedOwner(value);
                            editTask.owner.target = taskViewModel.selectedOwner;
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
