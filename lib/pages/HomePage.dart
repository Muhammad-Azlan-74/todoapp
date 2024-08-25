import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:practice/data/database.dart';
import 'package:practice/utility/dialog_box.dart';
import 'package:practice/utility/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final _myBox= Hive.openBox('myBox');
  final _myBox = Hive.openBox("myBox");
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState() {
    //first time opening :
    if (_myBox.get("TODOLIST") == null) {
      db.createinitialdata();
    } else {
      db.LoadData();
    }

    super.initState();
  }

  //text controller:
  final _controller = TextEditingController();
  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void deletetask(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  //function to change the check box:
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateDataBase();
  }

  void CreateNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[500],
      appBar: AppBar(
        title: Center(
          child: Text(
            'TO DO',
            style: TextStyle(
              color: Colors.white, // Set text color to white
              fontWeight: FontWeight.w800, // Set text to extra bold
              fontSize: 20, // Optional: Adjust font size
            ),
          ),
        ),
        backgroundColor: Color(0xFF004D40), // Custom Dark Green color
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: CreateNewTask,
        backgroundColor: Color(0xFF004D50), // Dark Green background color
        foregroundColor: Colors.white, // White color for the icon
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            onChanged: (value) => checkBoxChanged(value, index),
            taskCompleted: db.ToDoList[index][1],
            taskName: db.ToDoList[index][0],
            deleteTask: (context) => deletetask(index),
          );
        },
      ),
    );
  }
}
