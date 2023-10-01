import 'package:antiaddiction/main.dart';
import 'package:antiaddiction/providers/duration_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SetDuration extends StatelessWidget {
  const SetDuration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value=context.watch<DurationProvider>().value;
    var custom=context.watch<DurationProvider>().custom;
    var duration=context.watch<DurationProvider>().duration;
    return Center(
      child:
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (value!=7)?GestureDetector(
                  onTap: (){
                    context.read<DurationProvider>().onPrev(value);

                  },
                  child: Icon(
                    Icons.chevron_left_sharp,
                    color: HexColor("#544E50"),
                    size: MediaQuery.of(context).size.width*0.15,),
                ):Container(width: MediaQuery.of(context).size.width*0.15,),
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  height: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor("#F4717F")
                  ),
                  child: (custom)?Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.4,

                        child: TextField(
                                controller: duration,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.poppins(
                                      fontSize: MediaQuery.of(context).size.width*0.25,
                                      color: HexColor("#DAD8D9")
                                  ),
                                  textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          cursorColor: HexColor("#DAD8D9"),
                          onChanged: (value){
                                  print(value);
                                  context.read<DurationProvider>().textFieldChanged(value);
                          },




                              ),

                      ),
                      Text("days",
                        style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width*0.08,
                            color: HexColor("#DAD8D9")
                        ),
                        textAlign: TextAlign.center,


                      ),
                    ],

                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: Text(value.toString().padLeft(2,'0'),
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width*0.25,
                            color: HexColor("#DAD8D9")
                          ),
                            textAlign: TextAlign.center,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text("days",

                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width*0.08,
                              color: HexColor("#DAD8D9"),

                          ),
                          textAlign: TextAlign.center,


                        ),
                      ),
                    ],
                  ),
                ),
                (value!=90)?GestureDetector(
                  onTap: (){
                    context.read<DurationProvider>().onNext(value);
                  },
                    child: Icon(Icons.chevron_right_sharp,
                      color: HexColor("#544E50"),size: MediaQuery.of(context).size.width*0.15,)
                ):Container(width: MediaQuery.of(context).size.width*0.15,),


              ],
            ),
            SizedBox(height: 20,),
            (value==90 && !custom)?Container(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: (){
                  context.read<DurationProvider>().onCustom(value);

                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#544E50"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29)
                  ),

                ),
                child: Text("Custom".toUpperCase(),
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#DAD8D9")
                  ),
                ),
              )):Container(width: 100,
              height: 40,),

          ],
        )

    );
  }
}
