// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationApi {
//   static final _notification = FlutterLocalNotificationsPlugin();
//   static Future _notificationDetails()async{
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//       'channel id',
//       'channel name',
//       channelDescription: 'channel description',
//         icon: 'logo',
//         importance: Importance.max
//     ),
//     iOS: IOSNotificationDetails());
//   }
//
//   static Future showNotification({
//   int id ,
//   String title,
//   String body,
//   String payload,
// }) async =>
//       _notification.show(id, title, body,await _notificationDetails(),
//       payload: payload);
//
// }