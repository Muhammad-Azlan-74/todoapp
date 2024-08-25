import 'package:hive/hive.dart';

class ToDoDatabase{
  List ToDoList=[];
  //referto box:
  final _myBox=Hive.openBox("mybox");
  //run this method for first time opening of the app:
  void createinitialdata(){
    ToDoList=[
      ["Make Tutorial",false],
      ["DO coding",false]
    ];
  }
  void LoadData(){
    ToDoList=_myBox.get("TODOLIST");
  }

  //update:
void updateDataBase(){
    _myBox.put("TODOLIST",ToDoList);
}
}