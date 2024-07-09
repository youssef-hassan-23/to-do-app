// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_to_do/database.dart';
import 'package:my_to_do/task.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  DataBase db = DataBase();
  var mybox = Hive.box('mybox');
  @override
  void initState() {
    if (mybox.get('tasks') == null) {
      db.initalData();
    } else {
      db.uploadTasks();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: Text(
          "To do app",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.grey[200],
      //button to add data
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add new task"),
              backgroundColor: Colors.white,
              content: TextField(
                keyboardType: TextInputType.multiline,
                controller: controller,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        DataBase.tasks.add([controller.text, false]);
                        controller.clear();
                        db.updateTasks();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text("ok")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("cancel"))
              ],
            ),
          );
        },
        backgroundColor: Colors.amber,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.amber)),
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          // task list
          child: ReorderableListView(
        children: <Widget>[
          for (int index = 0; index < DataBase.tasks.length; index++)
            MyTask(
              key: Key("$index"),
              taskName: DataBase.tasks[index][0],
              done: DataBase.tasks[index][1],
              onChange: (value) {
                setState(() {
                  DataBase.tasks[index][1] = value;
                  db.updateTasks();
                });
              },
              deleteTask: (context) {
                setState(() {
                  DataBase.tasks.removeAt(index);
                });
                db.updateTasks();
              },
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final dynamic item = DataBase.tasks.removeAt(oldIndex);
            DataBase.tasks.insert(newIndex, item);
            db.updateTasks();
          });
        },
      )),
    );
  }
}
