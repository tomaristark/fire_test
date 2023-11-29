import 'package:fire_test/services/route.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScheduler{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  static const String kChannelID = "NotificationID";
  static const String kChannelName = "NotificationName";
  static const String kChannelDescription = "ChannelDescription";

  static final NotificationScheduler _scheduler =NotificationScheduler.internal();

  NotificationScheduler.internal(){
    init();
  }

  factory NotificationScheduler()=> _scheduler;

  void init()async{
    const androidInitializationSettings=AndroidInitializationSettings('@drawable/download');
    const iosInitializationSettings= DarwinInitializationSettings();
    const initializationSettings =InitializationSettings(
        android: androidInitializationSettings,iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,  onDidReceiveNotificationResponse:(notificationResponse)async{
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('notification', "");
      });
      NotificationRoute.route(notificationResponse.payload ?? '');
    });
  }

  Future displayNotification(
      String title ,String body,String payload,String ? imgURL)async{
    const iosNotificationDetail = DarwinNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(kChannelID, kChannelName,
        channelDescription: kChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: (imgURL != null && (imgURL.isNotEmpty)? null:const BigTextStyleInformation(''))
    );
    var platformChannelSpecifics =NotificationDetails(
        android: androidPlatformChannelSpecifics,iOS: iosNotificationDetail
    );

    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics,payload: payload);
  }
}