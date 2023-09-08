import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_list/view_models/event_view_model.dart';
import 'models/objectbox.dart';
import 'components/event_add.dart';
import 'screens/event_list_view.dart';

/// Provides access to the ObjectBox Store throughout the app.
late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ObjectBox Relations Application',
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
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
                onChanged: (text) {
                  // if (text.isEmpty) {
                  setState(() {
                    query = text;
                  });
                  // }
                },
                onSubmitted: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
              Expanded(
                  child: EventList(
                query: query,
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddEvent()));
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
