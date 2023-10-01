import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../providers/duration_provider.dart';

class DurationChange extends StatelessWidget {

  DurationChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value=context.watch<DurationProvider>().value;
    var custom=context.watch<DurationProvider>().custom;
    var duration=context.watch<DurationProvider>().duration;
    // var confirmUpdate=context.watch<DurationProvider>().confirmUpdate;
    return Stack(
      alignment: Alignment.center,
      children: [

       Container(
         width: 300,

         height: 400,
         child: Card(

      // decoration: BoxDecoration(
      //     color: HexColor("#E9E3E3"),
      //     borderRadius: BorderRadius.circular(10)
      // ),
           color: HexColor("#E9E3E3"),
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10)

           ),
      child: Column(

          children: [
            SizedBox(height: 10,),
            Text("Update Duration",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: HexColor("#544E50"),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none
              ),
              textAlign: TextAlign.center,

            ),
            SizedBox(height: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (value!=7)?GestureDetector(
                    onTap: (){
                      context.read<DurationProvider>().onPrev(value);

                    },
                    child: Icon(
                      Icons.chevron_left_sharp,
                      color: HexColor("#544E50"),
                      size: 20,),
                  ):
                  Container(width: 20,),
                  SizedBox(width: 10,),
                  Container(
                    width: 200,
                    height: 300,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HexColor("#F4717F")
                    ),
                    child:
                    (custom)?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 100,


                            child: TextField(
                              controller: duration,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: GoogleFonts.poppins(
                                  fontSize: 60,
                                  color: HexColor("#DAD8D9")
                              ),
                              keyboardType: TextInputType.number,
                              cursorColor: HexColor("#DAD8D9"),
                              onChanged: (value){
                                print(value);
                                context.read<DurationProvider>().textFieldChanged(value);
                              },
                            ),

                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text("days",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: HexColor("#DAD8D9"),
                                decoration: TextDecoration.none

                            ),
                            textAlign: TextAlign.center,


                          ),
                        ),
                      ],

                    ):
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,

                          child: Text(value.toString().padLeft(2,'0'),
                            style: GoogleFonts.poppins(
                                fontSize: 60,
                                color: HexColor("#DAD8D9"),
                                decoration: TextDecoration.none
                            ),
                            textAlign: TextAlign.center,

                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text("days",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: HexColor("#DAD8D9"),
                                decoration: TextDecoration.none

                            ),
                            textAlign: TextAlign.center,


                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),

                  (value!=90)?GestureDetector(
                      onTap: (){
                        context.read<DurationProvider>().onNext(value);
                      },
                      child: Icon(Icons.chevron_right_sharp,
                        color: HexColor("#544E50"),size: 20,)
                  ):Container(width: 20,),


                ],
              ),
            ),
            SizedBox(height: 20,),
            (value==90 && !custom)?Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
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
                  )
              ),
            ):Container(
              width: 100,
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: 200,

                child: ElevatedButton(
                  onPressed: (){
                    // context.read<DurationProvider>().setValue(number);
                    context.read<DurationProvider>().updateDuration(context);
                    // Navigator.pop(context);

                  },

                  style: ElevatedButton.styleFrom(
                      primary: HexColor("#FF355C")
                  ),
                  child: Text(
                    "Update".toUpperCase(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: HexColor("#E9E3E3"),
                        fontSize: 12
                    ),

                  ),

                ),
              ),
            )

          ],
      ),
    ),
       ),




      ],

    );
  }
}
