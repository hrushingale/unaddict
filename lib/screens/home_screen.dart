import 'package:antiaddiction/model/Boxes.dart';
import 'package:antiaddiction/model/DayTracker.dart';
import 'package:antiaddiction/providers/duration_provider.dart';
import 'package:antiaddiction/providers/home_screen_provider.dart';
import 'package:antiaddiction/screens/completed_days.dart';
import 'package:antiaddiction/screens/day_element_dialog.dart';
import 'package:antiaddiction/widgets/change_duration.dart';
import 'package:antiaddiction/widgets/day_element.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../service/ad_mob_service.dart';

class HomeScreen extends StatefulWidget {
  static const route='/homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  BannerAd? bannerAd;
  void createBannerAd(){
    bannerAd=BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest()
    )..load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBannerAd();
  }



  @override
  Widget build(BuildContext context) {
    var duration=context.watch<HomeScreenProvider>().duration;
    var sleepTime=context.watch<HomeScreenProvider>().sleepTime;
    var wakeTime=context.watch<HomeScreenProvider>().wakeUpTime;
    return Scaffold(
      backgroundColor: HexColor("#DADADA"),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     context.read<HomeScreenProvider>().launchInBrowser(Uri(scheme:'https',host: 'www.github.com',path: '/hrushingale/hrushingale-privacy/blob/main/privacy-policy.md'));
      //
      //   },
      //   backgroundColor: HexColor("#FF2F62"),
      //   child: Icon(Icons.policy_outlined),
      // ),

      bottomSheet: Container(
        height: 80,
        decoration: BoxDecoration(
          color: HexColor("#544E50"),

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: (sleepTime!=null&&wakeTime!=null)?Padding(
          padding: const EdgeInsets.only(left: 40,right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                constraints: BoxConstraints(),


                icon: Icon(Icons.wb_sunny_outlined,color: HexColor("#DADADA")),
              onPressed: (){
                  context.read<HomeScreenProvider>().changeWakeTime(context,wakeTime);
              },

              ),
              ValueListenableBuilder<Box<DayTracker>>(
                valueListenable: Boxes.getDays().listenable(),
                builder: (context,box,_){

                  final days=box.values.where((element) => element.done==true).toList().cast<DayTracker>();

                  return GestureDetector(

                    onTap: (){
                      if(days.isNotEmpty) {
                        showModalBottomSheet<dynamic>(

                          context: context,
                          isScrollControlled: true,




                          builder:(context)=> Wrap(
                              children: [
                                ChangeNotifierProvider(
                                    create:(_)=>HomeScreenProvider(),


                                    builder: (context, child) => CompletedDays()),
                              ]
                          ));
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "0 Days Completed! \nCome back later!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: HexColor("#DADADA"),
                            fontSize: 16.0
                        );
                      }
                    },
                    child: Text("Completed \n(${days.length})",

                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: HexColor("#DADADA"),
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );

                },


              ),
              IconButton(
                constraints: BoxConstraints(),

                icon:Icon(Icons.nightlight_round,color: HexColor("#DADADA"),),
                onPressed: (){
                  context.read<HomeScreenProvider>().changeSleepTime(context,sleepTime);

                },

                ),

            ],
          ),
        ):Center(child: Text("Loading...",

          style: GoogleFonts.poppins(
              fontSize: 16,
              color: HexColor("#DADADA"),
              fontWeight: FontWeight.w600
          ),
        ),)
      ),


      body: Stack(

        children: [




          SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 80,),
                (bannerAd==null)?Container():Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,

                  alignment: Alignment.center,
                  child: AdWidget(ad: bannerAd!),


                ),

                ValueListenableBuilder<Box<DayTracker>>(
                  valueListenable: Boxes.getDays().listenable(),
                  builder: (context,box,_){



                    final days=box.values.where((element) => element.done==false).toList().cast<DayTracker>();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: days.length,
                        itemBuilder: (context, index) {
                        final day=days[index];
                        return DayElement(dayTracker: day);
                    });

                  },


                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
                color: HexColor("#FF2F62"),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
            ),

            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){

                  showDialog(context: context, builder: (context)=>ChangeNotifierProvider(

                      create: (_)=>DurationProvider(),
                      child: DurationChange()));

                },

                child:ValueListenableBuilder<Box<DayTracker>>(
                  valueListenable: Boxes.getDays().listenable(),
                  builder: (context,box,_){



                    final days=box.values.toList().cast<DayTracker>();



                    return Text("Duration : ${days.length} days",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: HexColor("#DADADA"),
                          fontWeight: FontWeight.w600
                      ),

                    );

                  },


                ),


              ),
            ),
          ),



        ],
      ),
    );
  }
}
