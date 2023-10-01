import 'package:antiaddiction/widgets/day_element.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/Boxes.dart';
import '../model/DayTracker.dart';

class CompletedDays extends StatelessWidget {
  const CompletedDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.7,
      decoration: BoxDecoration(
        color: HexColor("#D9C8C0"),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)
          
        )
      ),
      child: ValueListenableBuilder<Box<DayTracker>>(
        valueListenable: Boxes.getDays().listenable(),
        builder: (context,box,_){

          final days=box.values.where((element) => element.done==true).toList().cast<DayTracker>();

          return SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),

                itemCount: days.length,


                itemBuilder: (context, index) {
                  final day=days[index];
                  return DayElement(dayTracker: day,);

                }),
          );

        },


      ),
    );
  }
}
