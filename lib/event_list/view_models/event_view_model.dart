import 'package:flutter/material.dart';

import '../../models/objectbox.dart';

late ObjectBox objectbox;

class EventViewModel extends ChangeNotifier {


  EventViewModel() {
    initObjectBox();
  }

  initObjectBox () async {
    objectbox = await ObjectBox.create();
    print('EventViewModel');

  }

}
