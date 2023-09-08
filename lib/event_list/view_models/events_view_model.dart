import 'package:flutter/material.dart';

import '../../objectbox.g.dart';
import '../repo/objectbox.dart';
import '../models/event.dart';

late ObjectBox objectbox;

class EventViewModel extends ChangeNotifier {

  String _searchQuery = '';
  Event? _selectedEvent;
  // ignore: prefer_final_fields
  Event _addingEvent = Event('');

  String get searchQuery => _searchQuery;
  Event? get selectedEvent => _selectedEvent;
  Event? get addingEvent => _addingEvent;

  initObjectBox() async {
    objectbox = await ObjectBox.create();
  }

  setSearchQuery (String query) {
    _searchQuery = query;
    notifyListeners();
  }

  setSelectedEvent (Event event) {
    _selectedEvent = event;
    print(_selectedEvent!.toJson());
    notifyListeners();
  }

  addEvent () {
    Event newEvent = addingEvent!;
    objectbox.eventBox.put(newEvent, mode: PutMode.insert);
    _addingEvent = Event('');
  }

  editEvent () {
    objectbox.eventBox.put(_selectedEvent!, mode: PutMode.update);
    notifyListeners();
  }

  deleteEvent (int id) {
    objectbox.eventBox.remove(id);
  }

  loadData () {
    objectbox.putDemoData();
  }

  Stream<List<Event>> searchEvents() {
    final builder = objectbox.eventBox
        .query(Event_.description.contains(searchQuery, caseSensitive: false))
      ..order(Event_.id, flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
