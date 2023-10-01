import 'package:antiaddiction/model/DayTracker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../providers/home_screen_provider.dart';

class DayElementDialog extends StatefulWidget {


  DayTracker dayTracker;
  DayElementDialog({Key? key,required this.dayTracker}) : super(key: key);

  @override
  State<DayElementDialog> createState() => _DayElementDialogState();
}

class _DayElementDialogState extends State<DayElementDialog> {
  TextEditingController notes=TextEditingController();
  String noteText="";



  void setNote(String value){
    noteText=value;
    print("Note Text:"+noteText);


  }

  void saveNote(DayTracker dayTracker){
    dayTracker.note=noteText;
    dayTracker.save();
    print("note saved");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      notes.text=widget.dayTracker.note;

    });

  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
        width: 300,
        height: 280,
        child: Card(
          semanticContainer: true,
          color: HexColor("#D9C8C0"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),

          child: Column(
            children: [
              SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.dayTracker.title,style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor("#2B2B2B")
                              ),),
                              Text(
                                DateFormat("dd MMM yy").format(widget.dayTracker.dateTime),
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor("#2B2B2B")
                                ),




                              ),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      widget.dayTracker.done=!widget.dayTracker.done;
                                    });
                                    widget.dayTracker.save();

                                    // context.read<HomeScreenProvider>().setDayStatus(widget.dayTracker,context);
                                    // // context.read<HomeScreenProvider>().setCompletedList();

                                  },


                                  child:Icon(Icons.star,color: (widget.dayTracker.done)?HexColor("#F4717F"):HexColor("#DADADA"),))

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                            child: SizedBox(
                              height: 150,
                              child: TextField(
                                keyboardType: TextInputType.multiline,


                                controller: notes,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                ),
                                maxLines: 5,

                                decoration: InputDecoration(

                                    fillColor: HexColor("#D9C8C0"),
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),



                                    prefixIconConstraints: BoxConstraints(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: HexColor("#E9E3E3"),width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),


                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: HexColor("#DAD8D9"),width: 2),
                                    ),
                                    hintText: "Enter note...",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.black45
                                    )




                                ),

                                onChanged: (value){
                                  // setNotes(value);
                                  // print(value);
                                  setNote(value);

                                },
                              ),
                            ),
                          ),

              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                    onPressed: (){
                      saveNote(widget.dayTracker);
                      Navigator.pop(context);

                    },
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#F4717F")
                    ),
                    child: Text(

                      "Save".toUpperCase(),
                      style: GoogleFonts.poppins(

                        fontSize: 12,
                        color: HexColor("#E9E3E3")

                      ),


                    )),
              )

            ],
          ),

        ),
      ),]
    );


    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.all(20),
    //       child: Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: 300,
    //         decoration: BoxDecoration(
    //             color: HexColor("#D9C8C0"),
    //             borderRadius: BorderRadius.circular(10),
    //             boxShadow: const [
    //               BoxShadow(
    //                 color: Colors.black12,
    //                 blurRadius: 10,
    //               )
    //             ]
    //         ),
    //         padding: EdgeInsets.only(top: 20),
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(dayTracker.title,style: GoogleFonts.poppins(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500,
    //                     color: HexColor("#2B2B2B")
    //                 ),),
    //                 Text(
    //                   DateFormat("dd MMM yy").format(dayTracker.dateTime),
    //                   style: GoogleFonts.poppins(
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.w500,
    //                       color: HexColor("#2B2B2B")
    //                   ),
    //
    //
    //
    //
    //                 ),
    //                 GestureDetector(
    //                     onTap: (){
    //                       context.read<HomeScreenProvider>().setDayStatus(dayTracker);
    //                       // context.read<HomeScreenProvider>().setCompletedList();
    //
    //                     },
    //
    //
    //                     child:Icon(Icons.star,color: (dayTracker.done)?HexColor("#F4717F"):HexColor("#DADADA"),))
    //
    //               ],
    //             ),
    //             TextField(
    //               controller: notes,
    //               style: GoogleFonts.inter(
    //                   fontWeight: FontWeight.w600,
    //                   color:HexColor("#DADADA")
    //               ),
    //
    //               decoration: InputDecoration(
    //
    //                   fillColor: HexColor("#222222"),
    //                   filled: true,
    //                   contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
    //
    //
    //
    //                   prefixIconConstraints: BoxConstraints(),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(color: Colors.transparent),
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //
    //
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(20),
    //                     borderSide: BorderSide(width: 0,style: BorderStyle.none),
    //                   ),
    //                   hintText: "Notes",
    //                   hintStyle: GoogleFonts.roboto(
    //                       fontSize: 16,
    //                       color: HexColor("#DADADA").withOpacity(0.5)
    //                   )
    //
    //
    //
    //
    //               ),
    //
    //               onChanged: (value){
    //                 // setNotes(value);
    //
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     )
    //
    //   ],
    // );
  }
}
