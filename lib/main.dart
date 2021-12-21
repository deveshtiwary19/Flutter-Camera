import 'package:assignment/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main(List<String> args) async {
  runApp(const MyApp());
}

//Following is the launcher widget, that connects the starting/landing page
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Internship Application',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
