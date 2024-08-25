import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)?deleteTask;
  TodoTile({super.key,required this.onChanged,required this.deleteTask,
    required this.taskCompleted,required this.taskName});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0,top: 60 ,right: 40),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteTask,
            icon: Icons.delete,
            backgroundColor: Colors.red,)
          ],
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children:
              [
                //check box:
               Checkbox(value: taskCompleted, onChanged: onChanged,
               activeColor: Colors.deepOrange,),
        
                //task name
                Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white, // Line-through color
                    decorationThickness: 3, // Adjust the thickness as needed
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.bold, // Text boldness
                  ),
                )
                ],
            ),
          ),
          decoration: BoxDecoration(color: Color(0xFF004D40),
          borderRadius:BorderRadius.circular(12)),
        ),
      ),
    );

  }
}
