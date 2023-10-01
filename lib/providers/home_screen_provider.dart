
import 'package:antiaddiction/model/DayTracker.dart';
import 'package:antiaddiction/screens/congratulations.dart';
import 'package:antiaddiction/service/ad_mob_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/notification_api.dart';
import '../model/Boxes.dart';

class HomeScreenProvider extends ChangeNotifier{

  bool dayStatus=false;
  int duration=0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // BannerAd? bannerAd;

  TimeOfDay? wakeUpTime;
  TimeOfDay? sleepTime;

  HomeScreenProvider(){
    // setTimeFix();
    getLastDay();
    // createBannerAd();
    getTime();
  }



  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void checkStatus(BuildContext context){



    final box=Boxes.getDays();
    final completed=box.values.where((element) => element.done==true);
    if(completed.length==box.values.length){
      print("congratulations");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CongratulationsScreen()));
    }
  }

  bool checkMark=false;

  Future<void> setTimeFix() async {
    final box=await Hive.openBox('time-details');
    box.put('sleepHour', 20);
    box.put('sleepMinute', 30);
    box.put('wakeHour', 07);
    box.put('wakeMin', 30);
  }

  void setDayStatus(DayTracker dayTracker,BuildContext context){
    checkMark=dayTracker.done;
    dayTracker.done=!dayTracker.done;
    dayTracker.save();
    checkMark=dayTracker.done;

    checkStatus(context);

    notifyListeners();



  }


  void getLastDay(){

    final box=Boxes.getDays();
    duration=box.values.length;
    notifyListeners();

  }


  void getTime()async{
    final box=await Hive.openBox('time-details');
    sleepTime=TimeOfDay(hour:box.get('sleepHour'),minute: box.get('sleepMin'));
    wakeUpTime=TimeOfDay(hour: box.get('wakeHour'), minute: box.get('wakeMin'));

    notifyListeners();

    print("time milala bhai");
  }

  void addToDB(String key, int value)async{
    final box=await Hive.openBox('time-details');
    box.put(key, value);

    print("time takla bhai");

  }


  void changeWakeTime(BuildContext context,TimeOfDay wakeUpTime) async {

    // getTime();

    final TimeOfDay? newTime=await showTimePicker(
        context: context,
        initialTime: wakeUpTime,
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: "Change Wake Up Time",

        builder: (context, child) {
          return Theme(
            child: child!,
            data: ThemeData(
              // primaryColor: HexColor("#F4717F"),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: HexColor("#F4717F"),
                selectionHandleColor: HexColor("#F4717F"),

              ),

              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),


                  )
              ),

              timePickerTheme: TimePickerThemeData(
                  inputDecorationTheme: InputDecorationTheme(

                    border: InputBorder.none,
                    focusColor: HexColor("#F4717F"),



                  ),

                  dayPeriodColor: Colors.transparent,
                  dayPeriodBorderSide: BorderSide(color: Colors.transparent),

                  dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected) ? HexColor("#F4717F") : Colors.black),
                  dayPeriodTextStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),


                  dialHandColor: HexColor("#F4717F"),
                  dialBackgroundColor: HexColor("#E9E3E3"),


                  helpTextStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),

                  backgroundColor: HexColor("#D9C8C0"),



                  hourMinuteTextStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: HexColor("#F4717F")
                  ),

                  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected) ? HexColor("#F4717F") : Colors.transparent),
                  hourMinuteTextColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.selected) ? HexColor("#D9C8C0") : HexColor("#F4717F"))),




            ),
          ) ;
        }
    );
    print(newTime);

    if(newTime!=null)
    {
      addToDB('wakeHour', newTime.hour);
      addToDB('wakeMin', newTime.minute);
      getTime();
      cancelNotification(1);
      NotificationApi.showScheduleNotification(


        title: "It's a new day!",
        body: "You are now stronger than yesterday! You can and will do it!",
        payload: "", hours: newTime.hour, minutes: newTime.minute, seconds: 00, id: 1,

      );
    }
    // wakeUpTime=newTime;
    // notifyListeners();
  }

  void changeSleepTime(BuildContext context,TimeOfDay sleepTime) async {


    final TimeOfDay? newTime=await showTimePicker(
        context: context,
        initialTime: sleepTime,
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: "Change Sleep Time",

        builder: (context, child) {
          return Theme(
            child: child!,
            data: ThemeData(
              // primaryColor: HexColor("#F4717F"),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: HexColor("#F4717F"),
                selectionHandleColor: HexColor("#F4717F"),

              ),

              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                    foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),


                  )
              ),

              timePickerTheme: TimePickerThemeData(
                  inputDecorationTheme: InputDecorationTheme(

                    border: InputBorder.none,
                    focusColor: HexColor("#F4717F"),



                  ),

                  dayPeriodColor: Colors.transparent,
                  dayPeriodBorderSide: BorderSide(color: Colors.transparent),

                  dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected) ? HexColor("#F4717F") : Colors.black),
                  dayPeriodTextStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),


                  dialHandColor: HexColor("#F4717F"),
                  dialBackgroundColor: HexColor("#E9E3E3"),


                  helpTextStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),

                  backgroundColor: HexColor("#D9C8C0"),



                  hourMinuteTextStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: HexColor("#F4717F")
                  ),

                  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected) ? HexColor("#F4717F") : Colors.transparent),
                  hourMinuteTextColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.selected) ? HexColor("#D9C8C0") : HexColor("#F4717F"))),




            ),
          ) ;
        }
    );
    if(newTime!=null)
    {
      addToDB('sleepHour', newTime.hour);

      addToDB('sleepMin', newTime.minute);
      getTime();
      cancelNotification(2);

        NotificationApi.showScheduleNotification(
          title: "You have done it!",
          body: "Mark off today's day!",
          payload: "", hours: sleepTime.hour, minutes: sleepTime.minute, seconds: 00, id: 2,
        );

    }

    // wakeUpTime=newTime;
    notifyListeners();
  }

  void cancelNotification(int id)async{
    await FlutterLocalNotificationsPlugin().cancel(id);
    print("cancelled");

  }

  // void setNotifications(){
  //   NotificationApi.init(initScheduled: true);
  //
  //
  //
  //   NotificationApi.showScheduleNotification(
  //     title: "You have done it!",
  //     body: "Mark off today's day!",
  //     payload: "", hours: sleepTime.hour, minutes: sleepTime.minute, seconds: 00, id: 2,
  //   );
  //
  //   print("initialized with todays date and notification");
  //
  // }



}