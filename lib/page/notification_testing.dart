import 'package:flutter/material.dart';
import 'package:progress/components/notification.dart';

class NotificationTesting extends StatelessWidget {
  const NotificationTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () {
              NotiService().showNotification(
                title: "Test Notification",
                body: "This is a test notification",
              );
            },
            child: const Text('Show Notification')),
        ElevatedButton(
            onPressed: () {
              NotiService().scheduleNotification(
                title: "Progress",
                body: "Did you completed your task? or again procastionating ?",
                hour: 18,
                minute: 0,
              );
            },
            child: const Text("Schedule Notification")),
      ])),
    );
  }
}
