import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'noti_scheduler.dart';

class FcmService{
  static final FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;

  void init()async{
    firebaseMessaging.requestPermission(sound: true,badge: true,alert: true);

    try {
    await firebaseMessaging.getToken().then(
            (token) {
                  print("Fcm token ========> $token");
            }
    );}catch (e){
      print(e);
    }

    //fore ground
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      await showNotification(message.data);
    });
    //background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
    await  showNotification(message.data);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("notification", message.data['noti_type']);
  }

  static Future<void> showNotification(Map<String,dynamic> data)async{
    NotificationScheduler().displayNotification(
        data['title'],
        data['body'],
        data['noti_type'],
        data['image']
    );
  }
}