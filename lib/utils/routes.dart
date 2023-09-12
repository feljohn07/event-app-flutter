import 'package:flutter/material.dart';
import 'package:sqliteapp/dashboard/view/dashboard.dart';
import 'package:sqliteapp/event_list/views/event_view.dart';
import 'package:sqliteapp/owner_list/view/owner_view.dart';

List<Map<String, dynamic>> routes = [
  {
    'title': const Text(''),
    'icon': const Icon(Icons.dashboard),
    'widget': const Dashboard(),
    'isHeader': true
  },
  {
    'title': const Text('Dashboard'),
    'icon': const Icon(Icons.dashboard),
    'widget': const Dashboard(),
    'isHeader': false
  },
  {
    'title': const Text('Events'),
    'icon': const Icon(Icons.event_available),
    'widget': const EventView(),
    'isHeader': false
  },
  {
    'title': const Text('Owners'),
    'icon': const Icon(Icons.people),
    'widget': const OwnerView(),
    'isHeader': false
  },
];
