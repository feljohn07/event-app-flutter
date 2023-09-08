import 'package:flutter/material.dart';
import 'event_list/view_models/events_view_model.dart';

import 'package:provider/provider.dart';
import 'package:sqliteapp/event_list/views/add_event_view.dart';
import 'package:sqliteapp/event_list/views/event_list_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ObjectBox
  EventViewModel _ = EventViewModel();
  _.initObjectBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventViewModel()),
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
  @override
  Widget build(BuildContext context) {
    EventViewModel eventViewModel = context.watch<EventViewModel>();
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  print('is loading');
                  await eventViewModel.loadData();
                  print('is loaded');
                },
                icon: const Icon(Icons.download))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
                onChanged: (text) {
                  setState(() {
                    eventViewModel.setSearchQuery(text);
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    eventViewModel.setSearchQuery(value);
                  });
                },
              ),
              const Expanded(child: EventList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddEventView()));
          },
          child: const Icon(Icons.add),
        ));
  }
}



// class _MyHomePageState extends State<MyHomePage> {
//   String query = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             children: [
//               TextField(
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(),
//                   labelText: 'Search',
//                 ),
//                 onChanged: (text) {
//                   // if (text.isEmpty) {
//                   setState(() {
//                     query = text;
//                   });
//                   // }
//                 },
//                 onSubmitted: (value) {
//                   setState(() {
//                     query = value;
//                   });
//                 },
//               ),
//               Expanded(
//                   child: EventList(
//                 query: query,
//               )),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => const AddEvent()));
//           },
//           child: const Icon(Icons.add),
//         ));
//   }
// }
