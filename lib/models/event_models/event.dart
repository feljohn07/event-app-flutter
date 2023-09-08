import 'package:objectbox/objectbox.dart';
// import 'objectbox.g.dart';

import 'task.dart';

@Entity()
class Event {
  @Id()
  int id;
  String name;
  String? description;

  @Property(type: PropertyType.date)
  DateTime? date;
  String? location;

  Event(this.name, {this.id = 0, this.description, this.date, this.location});

  @Backlink('event')
  final tasks = ToMany<Task>();
}
