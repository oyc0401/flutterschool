import 'package:flutter/material.dart';

import 'lunch.dart';
import 'timetable.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: TimeTable(),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Lunch(),
          ),
          Container(height: 400,)
        ],
      ),
    );
  }
}