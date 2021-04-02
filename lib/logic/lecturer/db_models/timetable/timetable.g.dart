// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeTableAdapter extends TypeAdapter<TimeTable> {
  @override
  final int typeId = 100;

  @override
  TimeTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeTable(
      periods: (fields[0] as List)
          ?.map((dynamic e) => (e as List)?.cast<Period>())
          ?.toList(),
      weekInfo: (fields[1] as Map)?.cast<dynamic, dynamic>(),
      prevVersion: fields[2] as TimeTable,
      lastModified: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TimeTable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.periods)
      ..writeByte(1)
      ..write(obj.weekInfo)
      ..writeByte(2)
      ..write(obj.prevVersion)
      ..writeByte(3)
      ..write(obj.lastModified);
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

class PeriodAdapter extends TypeAdapter<Period> {
  @override
  final int typeId = 120;

  @override
  Period read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Period(
      courseName: fields[0] as String,
      courseInfo: fields[1] as String,
      start: fields[3] as int,
      stop: fields[4] as int,
      state: fields[5] as String,
      group: fields[2] as List,
      venue: fields[6] as String,
      data: (fields[7] as Map)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Period obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.courseName)
      ..writeByte(1)
      ..write(obj.courseInfo)
      ..writeByte(2)
      ..write(obj.group)
      ..writeByte(3)
      ..write(obj.start)
      ..writeByte(4)
      ..write(obj.stop)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.venue)
      ..writeByte(7)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
