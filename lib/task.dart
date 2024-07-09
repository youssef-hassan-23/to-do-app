import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyTask extends StatelessWidget {
  final String taskName;
  final bool done;
  final Function(bool?)? onChange;
  final Function(BuildContext)? deleteTask;
  MyTask({
    super.key,
    required this.taskName,
    required this.done,
    required this.onChange,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTask,
            backgroundColor: Colors.red,
            icon: Icons.delete_outline,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Checkbox(
                activeColor: done ? Colors.grey : Colors.black,
                onChanged: onChange,
                value: done,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                taskName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: done ? Colors.grey : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
