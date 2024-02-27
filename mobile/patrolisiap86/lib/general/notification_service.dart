import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:mobilepatrol/general/session.dart';
import 'package:mobilepatrol/page/sosCallback.dart';

class NotificationService{
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService(){
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future <void> init(session sess,int id, String title, String message, String Payload, BuildContext context) async{
    final AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, onDidReceiveNotificationResponse: (details) {
        // details.payload = ""
        print("This is payload");
        print(details.payload);

        Navigator.push(context,MaterialPageRoute(builder: (context) => sosCallBack(sess, details.payload)));
        // ScreenArguments("ID", Payload);
      },
    );
    

    const AndroidNotificationDetails androidPlatformChannelSpecifics = 
    AndroidNotificationDetails(
        "channelId_1",
        "channelName",
        channelDescription: "",
        importance: Importance.max,
        // sound: UriAndroidNotificationSound("sound/alert.mp3")
        sound: RawResourceAndroidNotificationSound("alert")
    );

    const NotificationDetails platfomChanelSpesific = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id, title, message, platfomChanelSpesific, payload: Payload
    );
  }
  

}