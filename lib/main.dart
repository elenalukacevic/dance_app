import 'package:flutter/material.dart';
import 'list.dart';
import 'map.dart';
import 'details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Studio App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MapApp(),
      routes: {
        '/studios': (context) => ListScreen(),
        '/map': (context) => MapApp(),
      },
    );
  }
}