import 'package:antiaddiction/main.dart';
import 'package:antiaddiction/model/Boxes.dart';
import 'package:antiaddiction/model/DayTracker.dart';
import 'package:antiaddiction/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/notification_api.dart';


class DurationProvider extends ChangeNotifier{

  int value=7;
  bool custom=false;
  // int boxCleared=0;
  // int confirmUpdate=0;
  //
  // DurationProvider(){
  //   boxCleared=0;
  // }


  void setValue(int number){
    value=number;
    notifyListeners();
  }

  TextEditingController duration=TextEditingController(text: "");



  void onNext(int number){
    if(number==7){
      value=14;
    }
    else if(number==14){
      value=21;
    }
    else if(number==21){
      value=30;
    }
    else if(number==30){
      value=45;
    }
    else if(number==45){
      value=60;
    }
    else if(number==60){
      value=90;
    }
    else if(number==90){
      print("custom");
    }

    print(value);

    notifyListeners();
  }

  void onPrev(int number){

    if(number==14){
      value=7;
    }
    else if(number==21){
      value=14;
    }
    else if(number==30){
      value=21;
    }
    else if(number==45){
      value=30;
    }
    else if(number==60){
      value=45;
    }
    else if(number==90){
      value=60;
    }
    // durationController.add(value);
    print(value);

    notifyListeners();
  }
  void onCustom(int number){
    // duration.text=number.toString();
    custom=true;
    notifyListeners();
  }

  void textFieldChanged(String text){
    value=int.parse(text);
    print("value:"+value.toString());
    notifyListeners();
  }

  void sharedPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingStatus', true);

  }


  void addToHive()async{
    final box=Boxes.getDays();
    print("value is:"+value.toString());

    final timeBox=await Hive.openBox('time-details');
    DateTime? firstDate=timeBox.get('startDate');




    for(int i=0;i<value;i++){
      DayTracker dayTracker=DayTracker()
        ..dateTime=firstDate!.add(Duration(days: i))
        ..title="Day ${i+1}"
        ..note="";

      box.add(dayTracker);

    }
    // boxCleared=1;
    print("added");


  }


  void updateDuration(BuildContext context) async{
    final box=Boxes.getDays();
    if(value<box.length){

      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () async {

          int x=await wipeDB();

          if(x==1){
            addToHive();
          }





            // addToHive();

            // if(boxCleared==1){

          Navigator.pop(context);

          Navigator.pop(context);
            // }







        },
      );

      Widget cancelButton = TextButton(
        child: Text("CANCEL"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Confirm"),
        content: Text(
          "Since the new duration is less than the original one, all the data will be wiped out and a clean challenge will be initialized!",
          style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black,
              decoration: TextDecoration.none

          ),


        ),
        actions: [
          okButton,
          cancelButton
        ],
      );

      // //show entire db wipe out dialog
      print("hello");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );



    }
    else{
      DateTime firstDate=box.values.first.dateTime;
      int i=box.length;
      for(;i<value;i++){
        DayTracker dayTracker=DayTracker()
            ..done=false
            ..dateTime=firstDate.add(Duration(days: i))
            ..title="Day ${i+1}"
            ..note="";

        box.add(dayTracker);
      }


      print("duration updated");
      Navigator.pop(context);


    }


  }

  Future<int> wipeDB() async {
    final box=Boxes.getDays();
    await box.clear();

    return 1;





  }

}