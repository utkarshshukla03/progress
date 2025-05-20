import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../components/my_fab.dart';
import 'databases/note_db.dart';
import 'utlis/note_float.dart';
import 'utlis/note_tiles.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          HintText: 'Start Writing',
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

// cancel new habit
  void cancelDialogBox() {
    // clear textfield
    _controller.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // save existing habit with new name
  void existingName(int index) {
    setState(() {
      db.toDoList[index][0] = _controller.text;
    });
    _controller.clear();
    Navigator.pop(context);
    db.updateDataBase();
  }

  void editNote(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          HintText: db.toDoList[index][0],
          onSave: () => existingName(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black,
        backgroundColor: Colors.deepPurple[300],
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          'N O T E S ',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'ShadowsIntoLight',
              fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewTask,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context) => editNote(index),
          );
        },
      ),
    );
  }
}
