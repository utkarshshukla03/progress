import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box('mybox');

class ToDoDataBase {
  List toDoList = [];

  // reference our box

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
