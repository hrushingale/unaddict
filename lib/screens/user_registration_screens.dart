import 'package:antiaddiction/main.dart';
import 'package:antiaddiction/providers/duration_provider.dart';
import 'package:antiaddiction/providers/home_screen_provider.dart';
import 'package:antiaddiction/providers/onboarding_provider.dart';
import 'package:antiaddiction/providers/time_screen_provider.dart';
import 'package:antiaddiction/screens/home_screen.dart';
import 'package:antiaddiction/screens/loading_screen.dart';
import 'package:antiaddiction/widgets/set_duration.dart';
import 'package:antiaddiction/widgets/set_time.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class UserRegistrationScreen extends StatelessWidget {



  static const route='/timescreen';

  UserRegistrationScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var page=context.watch<OnboardingProvider>().page;

    return Scaffold(
      backgroundColor: HexColor("#DADADA"),
      bottomNavigationBar: (page!=2)?BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: SizedBox(

              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  print("page:"+page.toString());
                  if(page==0){

                    context.read<TimeScreenProvider>().addTime();

                  }
                  else if(page==1){
                    context.read<DurationProvider>().sharedPrefs();
                    context.read<DurationProvider>().addToHive();

                  }
                  context.read<OnboardingProvider>().setPage(++page,context);


                },
                style: ElevatedButton.styleFrom(
                    primary: HexColor("#FF315F"),
                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(30)
                    )
                ),
                child: Text(

                  "Continue".toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: HexColor("#DADADA"),
                  ),

                ),

              ),
            ),
          )
      ):Container(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (page==0)?SetTime():(page==1)?SetDuration():Container()

            ],
          ),
        ),
      ),
    );

    // return FutureBuilder(
    //   future: context.read<OnboardingProvider>().fetchPrefs(),
    //
    //
    //     builder: (context, snapshot) {
    //     if(snapshot.hasData){
    //       if(snapshot.data==false){
    //         return Scaffold(
    //           backgroundColor: HexColor("#DADADA"),
    //           bottomNavigationBar: (page!=2)?BottomAppBar(
    //             color: Colors.transparent,
    //             elevation: 0,
    //             child: Padding(
    //               padding: const EdgeInsets.all(50.0),
    //               child: SizedBox(
    //
    //                 height: 50,
    //                 child: ElevatedButton(
    //                     onPressed: (){
    //                       print("page:"+page.toString());
    //                       if(page==0){
    //
    //                         context.read<TimeScreenProvider>().addTime();
    //
    //                       }
    //                       else if(page==1){
    //                         context.read<DurationProvider>().sharedPrefs();
    //                         context.read<DurationProvider>().addToHive();
    //
    //                       }
    //                       context.read<OnboardingProvider>().setPage(++page,context);
    //
    //
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                         primary: HexColor("#FF315F"),
    //                         shape: RoundedRectangleBorder(
    //
    //                           borderRadius: BorderRadius.circular(30)
    //                       )
    //                   ),
    //                   child: Text(
    //
    //                     "Continue".toUpperCase(),
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.bold,
    //                       color: HexColor("#DADADA"),
    //                     ),
    //
    //                   ),
    //
    //                 ),
    //               ),
    //             )
    //         ):Container(),
    //         body: SafeArea(
    //           child: Center(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 (page==0)?SetTime():(page==1)?SetDuration():Container()
    //
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }
    //       else{
    //         return ChangeNotifierProvider(
    //
    //             create: (_)=>HomeScreenProvider(),
    //             child: HomeScreen());
    //       }
    //
    // }
    //     else{
    //       return CircularProgressIndicator();
    //     }
    //
    // });



  }
}
