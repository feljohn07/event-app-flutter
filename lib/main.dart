import 'package:flutter/material.dart';
import 'package:sqliteapp/dashboard/view_model/dashboard_view_model.dart';
import 'package:sqliteapp/event_list/view_models/object_box_view_model.dart';
import 'package:sqliteapp/event_list/views/event_view.dart';
import 'package:sqliteapp/owner_list/view_models/owner_view_model.dart';
import 'package:sqliteapp/task_list/view_models/task_view_model.dart';
import 'package:sqliteapp/utils/navigation_utils.dart';
import 'package:sqliteapp/utils/routes.dart';
import 'event_list/view_models/events_view_model.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ObjectBox
  ObjectBoxViewModel _ = ObjectBoxViewModel();
  _.initObjectBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObjectBoxViewModel()),
        ChangeNotifierProvider(create: (_) => EventViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => OwnerViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    try {
      page = routes[_selectedIndex]['widget'];
    } on Exception catch (e) {
      throw UnimplementedError('no widget for $_selectedIndex: $e');
    }

    ObjectBoxViewModel objectBoxViewModel = context.watch<ObjectBoxViewModel>();
    EventViewModel eventViewModel = context.watch<EventViewModel>();

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: routes.asMap().entries.map((e) {

            if(e.value['isHeader'] ) {
              return const DrawerHeader(
                child: Column(
                  children: [
                    Text('Event Manager'),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                  ],
                ),
              );
            }

            return ListTile(
              leading: e.value['icon'],
              title: e.value['title'],
              onTap: () {
                setState(() {
                  _selectedIndex = e.key;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
      body: page,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          opentAddEventView(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
