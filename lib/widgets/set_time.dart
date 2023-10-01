import 'package:antiaddiction/api/notification_api.dart';
import 'package:antiaddiction/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../providers/time_screen_provider.dart';
import 'package:provider/provider.dart';

class SetTime extends StatefulWidget {
  const SetTime({Key? key}) : super(key: key);

  @override
  State<SetTime> createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }
  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload){
    Navigator.pushNamed(context, HomeScreen.route);
  }




  @override
  Widget build(BuildContext context) {
    var sleep=context.watch<TimeScreenProvider>().sleepTime;

    var wake=context.watch<TimeScreenProvider>().wakeTime;
    var startDate=context.watch<TimeScreenProvider>().startDate;
    return Container(

      child: Column(
        children: [
          Text(
              "Start Date",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,

              )
          ),
          GestureDetector(
            onTap: (){

              context.read<TimeScreenProvider>().pickDate(context);

            },
            child: Text(DateFormat("dd MMM yyyy").format(startDate),
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: HexColor("#F4717F")
              ),
            ),
          ),
          Text(
              "Wake Up Time",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,

              )
          ),
          GestureDetector(
            onTap: (){

              context.read<TimeScreenProvider>().pickWakeUpTime(context);

            },
            child: Text(MaterialLocalizations.of(context).formatTimeOfDay(wake),
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: HexColor("#F4717F")
              ),
            ),
          ),
          Text(
              "Sleep Time",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              )
          ),
          GestureDetector(
            onTap: (){
              context.read<TimeScreenProvider>().pickSleepTime(context);

            },
            child: Text(MaterialLocalizations.of(context).formatTimeOfDay(sleep),
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: HexColor("#F4717F")
              ),
            ),
          ),
        ],
      ),

    );
  }
}
