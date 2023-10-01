import 'package:antiaddiction/model/DayTracker.dart';
import 'package:hive/hive.dart';

class Boxes{

  static Box<DayTracker> getDays()=>Hive.box('day-tracker');




}