import 'package:flutter/material.dart';
import 'package:sqliteapp/event_list/view_models/object_box_view_model.dart';

class DashboardViewModel extends ChangeNotifier {
  getEventsTotal() {
    return objectbox.eventBox.count();
  }

  getTaskTotal() {
    return objectbox.taskBox.count();
  }

  getOwnersTotal() {
    return objectbox.ownerBox.count();
  }
}
