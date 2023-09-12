import 'package:flutter/material.dart';
import 'package:sqliteapp/owner_list/models/owner.dart';

import '../../objectbox.g.dart';
import '../../event_list/view_models/object_box_view_model.dart';

class OwnerViewModel extends ChangeNotifier {
  Owner _selectedOwner = Owner('');
  // ignore: prefer_final_fields
  Owner _addingOwner = Owner('');

  Owner? get addingOwner => _addingOwner;
  Owner? get selectedOwner => _selectedOwner;

  void setSelectedOwner(Owner owner) {
    _selectedOwner = owner;
    notifyListeners();
  }

  void addOwner() {
    Owner newOwner = _addingOwner;
    objectbox.ownerBox.put(newOwner);
  }

  void editOwner() {
    objectbox.ownerBox.put(selectedOwner!);
  }

  void deleteOwner(int id) {
    objectbox.ownerBox.remove(id);
    notifyListeners();

  }

  Stream<List<Owner>> getOwners() {
    final builder = objectbox.ownerBox.query()
      ..order(Owner_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
