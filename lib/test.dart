import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List tasks = [
    "task",
    "task",
    "task",
    "task",
    "task",
    "task",
    "task",
    "task",
    "task",
    "task",
    "task",
    "task",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ReorderableListView(
        children: <Widget>[
          for (int i = 0; i < tasks.length; i++)
            ListTile(
              title: Text("Task$i"),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, item);
          });
        },
      )),
    );
  }
}
