import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../components/month_summary.dart';
import '../components/my_fab.dart';
import '../components/new_habit_box.dart';
import '../components/notification.dart';
import '../data/habit_database.dart';
import 'habit_titles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  final NotiService _notiService = NotiService();

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _notiService.initNotification();

    // Load toggle state from Hive
    isSwitched = _myBox.get('notification_toggle', defaultValue: false);

    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    // show alert dialog for user to enter the new habit details
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabit(
          controller: _newHabitNameController,
          hintText: 'Enter habit name....',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });

    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel new habit
  void cancelDialogBox() {
    // clear textfield
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabit(
          controller: _newHabitNameController,
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  void _onToggleChanged(bool value) {
    setState(() {
      isSwitched = value;
      _myBox.put('notification_toggle', value); // Save toggle state
    });
    if (value) {
      _notiService.scheduleNotification(
        title: "Progress",
        body: "Completed your tasks? or again procrastinating hmm?",
        hour: 18,
        minute: 0,
      );
    } else {
      _notiService.cancelAllNotifications();
    }
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
          'P R O G R E S S',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'ShadowsIntoLight',
              fontWeight: FontWeight.bold),
        ),
        elevation: 5,
        actions: [
          Switch(
            value: isSwitched,
            onChanged: _onToggleChanged,
            activeColor: Colors.white,
          ),
        ],
      ),

      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: mobileScreen(),
      body: ListView(
        children: [
          // monthly summary heat map
          MonthlySummary(
            datasets: db.heatMapDataSet ?? {},
            startDate: _myBox.get("START_DATE") ?? DateTime.now(),
          ),

          // list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList?.length ?? 0,
            itemBuilder: (context, index) {
              return HabitTiles(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          )
        ],
      ),
    );
  }
}
