import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/DayTracker.dart';
import '../providers/home_screen_provider.dart';
import '../screens/day_element_dialog.dart';
class DayElement extends StatelessWidget {

  DayTracker dayTracker;
  DayElement({Key? key,required this.dayTracker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10.0,bottom: 10),


      child: Container(
        width: MediaQuery.of(context).size.width,
        height: (dayTracker.note.isNotEmpty)?100:60,


        decoration: BoxDecoration(
            color: HexColor("#D9C8C0"),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  showDialog(
                      context: context, builder: (context)=>
                      ChangeNotifierProvider(

                          create: (_)=>HomeScreenProvider(),
                          child: DayElementDialog(dayTracker: dayTracker,)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(dayTracker.title,style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#2B2B2B")
                    ),),
                    Text(
                      DateFormat("dd MMM yy").format(dayTracker.dateTime),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#2B2B2B")
                      ),




                    ),
                    IconButton(
                        onPressed: (){
                          context.read<HomeScreenProvider>().setDayStatus(dayTracker,context);
                          // context.read<HomeScreenProvider>().setCompletedList();

                        },


                        icon:Icon(Icons.star,color: (dayTracker.done)?HexColor("#F4717F"):HexColor("#DADADA"),))

                  ],
                ),
              ),
            ),
            (dayTracker.note.isNotEmpty)?ExpandablePanel(







              header:Center(
                child: Text(
                  "Daily Log",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: HexColor("#544E50"),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),


              collapsed: Icon(Icons.keyboard_arrow_down_rounded,size: 0,),
                expanded: Text(dayTracker.note),
              theme: const ExpandableThemeData(
                iconColor: Colors.black,
                iconSize: 20,
                iconPlacement: ExpandablePanelIconPlacement.left,
                expandIcon: Icons.keyboard_arrow_down_rounded,
                collapseIcon: Icons.keyboard_arrow_up_rounded,
                bodyAlignment: ExpandablePanelBodyAlignment.center,
                alignment: Alignment.center,
                tapHeaderToExpand: true,
                hasIcon: false,
                // tapHeaderToExpand: true,
              ),
              builder: (_,collapsed,expanded){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                  ),
                );
              },



            ):Container()
          ],
        ),
      ),
    );
  }
}
