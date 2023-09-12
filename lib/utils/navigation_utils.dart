import 'package:flutter/material.dart';
import 'package:sqliteapp/event_list/views/event_view.dart';
import 'package:sqliteapp/owner_list/view/add_owner_view.dart';
import 'package:sqliteapp/owner_list/view/edit_owner_view.dart';
import 'package:sqliteapp/owner_list/view/owner_view.dart';
import 'package:sqliteapp/task_list/views/add_task_view.dart';
import 'package:sqliteapp/event_list/views/edit_event_view.dart';
import 'package:sqliteapp/task_list/views/edit_task_view.dart';
import 'package:sqliteapp/task_list/views/event_task_list_view.dart';
import 'package:sqliteapp/event_list/views/add_event_view.dart';

// Events

void openEvent(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EventView(),
    ),
  );
}

void opentAddEventView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddEventView(),
    ),
  );
}

void openEventEditView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EditEventView(),
    ),
  );
}

// Tasks

void opentTaskListView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TaskListView(),
    ),
  );
}

void opentAddTaskView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddTaskView(),
    ),
  );
}

void opentEditTaskView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EditTaskView(),
    ),
  );
}

// Owners

void openOwnersView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const OwnerView(),
    ),
  );
}

void openAddOwnerView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddOwnerView(),
    ),
  );
}

void openEditOwnerView(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EditOwnerView(),
    ),
  );
}


// void openAddUser(BuildContext context) async {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => AddUserScreen(),
//     ),
//   );
// }

