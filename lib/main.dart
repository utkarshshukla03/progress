import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progress/components/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboard/onboard.dart';
import 'slide_page.dart';

bool? seenOnboard;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init notification

  NotiService().initNotification();
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false;
  // initialize hive
  await Hive.initFlutter();

  // open a box
  await Hive.openBox("Habit_DataBase");

  var box = await Hive.openBox('mybox');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: seenOnboard == true ? Slide() : OnBoarding(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
