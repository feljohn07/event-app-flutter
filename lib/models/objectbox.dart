import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:faker_dart/faker_dart.dart';
import 'package:sqliteapp/models/event_models/event.dart';
import 'package:sqliteapp/models/event_models/owner.dart';
import 'package:sqliteapp/models/event_models/task.dart';
import 'package:sqliteapp/objectbox.g.dart';

class ObjectBox {
  late final Store store;

  late final Box<Task> taskBox;
  late final Box<Owner> ownerBox;
  late final Box<Event> eventBox;

  final String _query = '';

  String get query => _query;

  ObjectBox._create(this.store) {
    taskBox = Box<Task>(store);
    ownerBox = Box<Owner>(store);
    eventBox = Box<Event>(store);

    // _putDemoData();
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, 'obx-examples'));
    return ObjectBox._create(store);
  }

  void _putDemoData() {

    Faker faker = Faker.instance;
    List<Owner> owners = [];

    for (int i = 0; i <= 10; i++) {
      Owner owner = Owner(faker.name.fullName());
      owners.add(owner);
    }

    for (int i = 0; i < 10000; i++) {
      Event event = Event(faker.name.jobSector(),  description: faker.lorem.sentence(), date: DateTime.now(), location: faker.address.city());
      Task task = Task(faker.lorem.sentence(wordCount: 20));

      task.owner.target = owners[Random().nextInt(10)];

      event.tasks.add(task);

      eventBox.put(event);
    }

    print('done');

  }

  void addTask(String taskText, Owner owner, Event event) {
    Task newTask = Task(taskText);
    newTask.owner.target = owner;

    Event updatedEvent = event;
    updatedEvent.tasks.add(newTask);
    newTask.event.target = updatedEvent;

    eventBox.put(updatedEvent);

    debugPrint(
        'Added Task: ${newTask.text} assigned to ${newTask.owner.target?.name} in event: ${updatedEvent.name}');
  }

  void addEvent(String name, DateTime date, String location) {
    Event newEvent = Event(name, date: date, location: location);

    eventBox.put(newEvent);
    debugPrint('Added Event: ${newEvent.name}');
  }
  
  int addOwner(String newOwner) {
    Owner ownerToAdd = Owner(newOwner);
    int newObjectId = ownerBox.put(ownerToAdd);

    return newObjectId;
  }

  void deleteEvent(int id) {
    eventBox.remove(id);

    debugPrint('Deleted Event: $id}');
  }

  Stream<List<Event>> getEvents() {
    final builder = eventBox.query()..order(Event_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Event>> searchEvents(String query) {
    final builder = eventBox
        .query(Event_.description.contains(query, caseSensitive: false))
      ..order(Event_.id, flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Task>> getTasksOfEvent(int eventId) {
    final builder = taskBox.query()..order(Task_.id, flags: Order.descending);
    builder.link(Task_.event, Event_.id.equals(eventId));
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
