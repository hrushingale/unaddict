// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DayTracker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayTrackerAdapter extends TypeAdapter<DayTracker> {
  @override
  final int typeId = 0;

  @override
  DayTracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayTracker()
      ..title = fields[0] as String
      ..dateTime = fields[1] as DateTime
      ..note = fields[2] as String
      ..done = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, DayTracker obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayTrackerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
