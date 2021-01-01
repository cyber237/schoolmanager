// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeTableAdapter extends TypeAdapter<TimeTable> {
  @override
  final int typeId = 0;

  @override
  TimeTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeTable(
      cells: (fields[0] as List)?.cast<dynamic>(),
      weekInfo: (fields[1] as Map)?.cast<dynamic, dynamic>(),
      prevVersion: fields[2] as TimeTable,
    );
  }

  @override
  void write(BinaryWriter writer, TimeTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cells)
      ..writeByte(1)
      ..write(obj.weekInfo)
      ..writeByte(2)
      ..write(obj.prevVersion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
