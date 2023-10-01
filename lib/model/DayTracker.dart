
import 'package:hive/hive.dart';
part 'DayTracker.g.dart';

@HiveType(typeId: 0)
class DayTracker extends HiveObject{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late DateTime dateTime;

  @HiveField(2)
  String note="";

  @HiveField(3)
  bool done=false;

}