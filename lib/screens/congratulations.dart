import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Lottie.asset(
                "lottie/congratulations.json",
                repeat: true
            ),
            SizedBox(height: 10,),
            Text(
                "Congratulations!".toUpperCase(),
              style: GoogleFonts.poppins(

                fontSize: MediaQuery.of(context).size.width*0.07,
                fontWeight: FontWeight.bold,
                color: HexColor("#F4717F")


              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Don't give up just yet! \nGo back and extend your challenge!",
              style: GoogleFonts.poppins(

                  fontSize: MediaQuery.of(context).size.width*0.03,
                  fontWeight: FontWeight.bold,
                  color: HexColor("#544E50")


              ),
              textAlign: TextAlign.center,
            ),
          ]
        ),
      ),
    );
  }
}
