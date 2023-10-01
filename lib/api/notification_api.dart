
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;


class NotificationApi{
  static final _notifications=FlutterLocalNotificationsPlugin();

  static final onNotifications=BehaviorSubject<String?>();


  static Future _notificationDetails() async{



    return NotificationDetails(

      android: AndroidNotificationDetails(
        'channel id',
        'channel name',

        importance: Importance.max,
        color: Colors.transparent,
        icon: '@mipmap/ic_launcher',
      )


    );
  }
  
  static void showScheduleNotification({
  
  required int id,
    String? title,
    String? body,
    String? payload ,
    required int hours, required int minutes, required int seconds,

}) async=>_notifications.zonedSchedule(id,
      title,
      body,
      _scheduleDaily(Time(hours,minutes,seconds)),
      await _notificationDetails(),
      payload: payload,
    androidAllowWhileIdle: true,

    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );



  static tz.TZDateTime _scheduleDaily(Time time){

    final now=tz.TZDateTime.now(tz.local);
    final scheduledDate=tz.TZDateTime(tz.local,now.year,now.month,now.day,time.hour,time.minute,time.second);

    return scheduledDate.isBefore(now)?scheduledDate.add(Duration(days: 1)):scheduledDate;


  }

  static Future init({bool initScheduled=false}) async{
    final android=AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings=InitializationSettings(android: android);

    await _notifications.initialize(settings,

        onDidReceiveNotificationResponse: ((payload) {

          onNotifications.add(payload.toString());

        }



        ));



    //     onSelectNotification: ((payload) {
    //
    //       onNotifications.add(payload);
    //
    // }));




    if(initScheduled){

      tz.initializeTimeZones();

      final locationName=await FlutterNativeTimezone.getLocalTimezone();
        tz.setLocalLocation(
            tz.getLocation(locationName)

        );


    }


  }





}