import 'package:flutter/material.dart';
import 'package:sqliteapp/owner_list/models/owner.dart';
import 'package:sqliteapp/task_list/models/task.dart';
import 'package:sqliteapp/event_list/models/event.dart';

import '../../objectbox.g.dart';
import '../../event_list/view_models/object_box_view_model.dart';

class TaskViewModel extends ChangeNotifier {
  Task _selectedTask = Task('');
  Owner? _selectedOwner;
  // ignore: prefer_final_fields
  Task _addingTask = Task('');

  Task get selectedTask => _selectedTask;
  Owner? get selectedOwner => _selectedOwner;
  Task? get addingTask => _addingTask;

  setSelectedTask (Task task) {
    _selectedTask = task;
    notifyListeners();
  }

  setSelectedOwner (Owner? owner) {
    print(owner?.name);
    _selectedOwner = owner;
    notifyListeners();
  }

  void addTask(Event event, Owner owner) {
    print(owner.name);
    Task newTask = Task(_addingTask.text);
    newTask.owner.target = owner;

    Event updatedEvent = event;
    updatedEvent.tasks.add(newTask);
    newTask.event.target = updatedEvent;

    objectbox.eventBox.put(updatedEvent);

    debugPrint(
        'Added Task: ${newTask.text} assigned to ${newTask.owner.target?.name} in event: ${updatedEvent.name}');
  }

  void editTask() {
    objectbox.taskBox.put(selectedTask, mode: PutMode.update);
  }

  void toggleTaskStatus(Task task) {
    task.status = !task.status;
    objectbox.taskBox.put(task);
    notifyListeners();
  }

  deleteTask(int id) {
    objectbox.taskBox.remove(id);
    notifyListeners();
  }

  Stream<List<Task>> getTasks(Event selectedEvent) {
    final builder = objectbox.taskBox.query()
      ..order(Task_.id, flags: Order.descending);
    builder.link(Task_.event, Event_.id.equals(selectedEvent.id));
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
