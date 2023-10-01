
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class OnboardingImage extends StatelessWidget {

  String url;
  String text1;
  String text2;
  double width;
  double height;

  OnboardingImage({Key? key,required this.url,required this.text1,required this.text2,required this.width,required this.height}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: width,
            height: height,

            child: Lottie.asset(
                url,

                // controller: loadingController,
                repeat: true,
                // animate: true,
                // onLoaded: (value){
                //   loadingController.forward();
                //
                //
                //
                //
                // }
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            text1,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black

            ),
            textAlign: TextAlign.center,

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right:20,bottom: 20 ),
          child: Text(
            text2,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: HexColor("#544E50")
            ),
            textAlign: TextAlign.center,
          ),
        )

      ],
    );
  }
}
