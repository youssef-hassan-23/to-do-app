import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  var mybox = Hive.box('mybox');
  static List tasks = [];
  void initalData() {
    tasks = [
      ['task 1', false],
      ['task 2', false],
    ];
  }

  void uploadTasks() {
    tasks = mybox.get('tasks');
  }

  void updateTasks() {
    mybox.put('tasks', tasks);
  }
}
