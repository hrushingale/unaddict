

import 'package:antiaddiction/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';

import '../api/notification_api.dart';

class TimeScreenProvider extends ChangeNotifier{
  TimeOfDay sleepTime=TimeOfDay(hour: 22, minute: 00);
  TimeOfDay wakeTime=TimeOfDay(hour: 07, minute: 30);
  DateTime startDate=DateTime.now();



  void setSleepTime(TimeOfDay timeOfDay){
    sleepTime=timeOfDay;
    notifyListeners();

  }

  void setWakeTime(TimeOfDay timeOfDay){
    wakeTime=timeOfDay;
    notifyListeners();

  }

  void pickWakeUpTime(BuildContext context)async{

    final TimeOfDay? newTime=await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,

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


      wakeTime=newTime!;
    notifyListeners();




  }

  void pickSleepTime(BuildContext context)async{

    final TimeOfDay? newTime=await showTimePicker(



        context: context,
        initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,

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


    sleepTime=newTime!;
    notifyListeners();




  }

  void addTime() async {
    final box=await Hive.openBox('time-details');
    box.put('sleepHour', sleepTime.hour);
    box.put('sleepMin', sleepTime.minute);
    box.put('wakeHour', wakeTime.hour);
    box.put('wakeMin', wakeTime.minute);

    box.put('startDate', startDate);

    setNotifications();
    print("time takla bhai");


  }
  void setNotifications(){
    // NotificationApi.init(initScheduled: true);

    NotificationApi.showScheduleNotification(


      title: "It's a new day!",
      body: "You are now stronger than yesterday! You can and will do it!",
      payload: "", hours: wakeTime.hour, minutes: wakeTime.minute, seconds: 00, id: 1,

    );

    NotificationApi.showScheduleNotification(
      title: "You have done it!",
      body: "Mark off today's day!",
      payload: "", hours: sleepTime.hour, minutes: sleepTime.minute, seconds: 00, id: 2,
    );

    print("initialized with todays date and notification");

  }

  void setStartDate(DateTime dateTime){
    startDate=dateTime;
    notifyListeners();
  }

  void pickDate(BuildContext context)async{

    DateTime? dateTime=await showDatePicker(
      builder: (context, child) {
        return Theme(
          child: child!,
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: HexColor("#FF2F62")
            )
          )

        );
      },

        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year,01,31),
        lastDate: DateTime(DateTime.now().year+10,12,31)
    );

    if(dateTime!=null){
      setStartDate(dateTime);
    }



  }




}