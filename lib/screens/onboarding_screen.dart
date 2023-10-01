
import 'package:antiaddiction/screens/user_registration_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../providers/home_screen_provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_image.dart';
import 'home_screen.dart';



class OnboardingScreens extends StatelessWidget {
  static const route='/onboarding';

  OnboardingScreens({Key? key}) : super(key: key);


  PageController pageController=PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var page=context.watch<OnboardingProvider>().getPage;
    return FutureBuilder(
      future: context.read<OnboardingProvider>().fetchPrefs(),
      builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasData){
          return (snapshot.data==false)?Scaffold(
            backgroundColor: HexColor("#DADADA"),
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    onPageChanged: (index){

                      context.read<OnboardingProvider>().firstSetPage(index);

                    },
                    controller: pageController,
                    children: [
                      OnboardingImage(
                        url: 'lottie/1_set_duration.json',
                        text1: 'challenge duration'.toUpperCase(),
                        text2: 'Pre-defined & custom durations for challenges',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                      ),
                      OnboardingImage(
                        url: 'lottie/2_take notes_mark_as_done.json',
                        text1: 'mark as done'.toUpperCase(),
                        text2: 'Simply tap on the day star',
                        width: MediaQuery.of(context).size.width*0.7,
                        height: MediaQuery.of(context).size.width*0.7,

                      ),
                      OnboardingImage(
                        url: 'lottie/3_together.json',
                        text1: "and don't forget".toUpperCase(),
                        text2: 'We are in this together!',
                        width: MediaQuery.of(context).size.width*0.7,
                        height: MediaQuery.of(context).size.width*0.7,
                      ),

                    ],

                  ),
                ),
                // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,


                  effect: ExpandingDotsEffect(
                      spacing: 10,
                      activeDotColor: HexColor("#FF315F"),
                      expansionFactor: 5,


                      dotHeight: 8,
                      dotWidth: 8
                  ),

                  onDotClicked: (index)=>pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve:  Curves.easeInOut),
                ),
                const SizedBox(height: 40,),
                Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: (page!=2)?ElevatedButton(
                      onPressed: (){
                        pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
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


                    ):ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, UserRegistrationScreen.route);



                      },
                      child: Text(

                        "Get Started".toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#DADADA"),
                        ),

                      ),
                      style: ElevatedButton.styleFrom(
                          primary: HexColor("#FF315F"),
                          shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    )
                ),


                (page!=2)?TextButton(onPressed: (){

                  pageController.jumpToPage(2);
                }, child: Text("Skip",style: GoogleFonts.poppins(color: HexColor("#F4717F")),)):TextButton(onPressed: (){


                }, child: Text(""))
              ],
            ),




          ):MultiProvider(providers: [
              ChangeNotifierProvider(

              create: (_)=>HomeScreenProvider(),
       ),
          ],

              child: HomeScreen()
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }


      },

    );
  }
}
