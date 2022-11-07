
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:untitled1/db_handler.dart';
import 'package:untitled1/notes_model.dart';
import 'package:untitled1/notes_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  NotesScreen(),
    );
  }
}

