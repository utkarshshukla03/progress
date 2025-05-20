import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:timezone/timezone.dart" as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialize the notification service
  Future<void> initNotification() async {
    if (_isInitialized) return; //prevent re-initialization

    // init timezone handling
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // prepare android init settings
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // prepare ios init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    // finally, initialize the plugin
    await notificationsPlugin.initialize(initSettings);
  }

  // Notification detial setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // Show notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
  // on notification tapped

/*
Scheduled Notification at a specified time 

-hour(0-23)
-minute(0-59)

*/

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    // create a date/time for today at a specific hour and minute

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Schedule the notification

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      // iOS specific: Use exact time specified(vs relative time)
      // uiLocalNotificationDateInterpretation :
      //     UILocalNotificationDateInterpretation.absoluteTime,

      // android specific: Allow notification to be shown even when the device is in low-power mode
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      // make notification repeat daily at same time
      matchDateTimeComponents:
          DateTimeComponents.time, // repeat daily at same time
    );

    print("Notification Scheduled for $hour:$minute");
  }

// cancel all the the currently active
  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }
}
