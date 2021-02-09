// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 2;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      name: fields[0] as String,
      id: fields[1] as String,
      level: fields[2] as Level,
      hours: fields[3] as int,
      attendance: (fields[4] as List)?.cast<Attendance>(),
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.hours)
      ..writeByte(4)
      ..write(obj.attendance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttendanceAdapter extends TypeAdapter<Attendance> {
  @override
  final int typeId = 23;

  @override
  Attendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attendance(
      time: fields[0] as DateTime,
      remark: fields[1] as String,
      takenBy: fields[2] as String,
      sheet: (fields[3] as List)?.cast<Student>(),
    );
  }

  @override
  void write(BinaryWriter writer, Attendance obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.remark)
      ..writeByte(2)
      ..write(obj.takenBy)
      ..writeByte(3)
      ..write(obj.sheet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LevelAdapter extends TypeAdapter<Level> {
  @override
  final int typeId = 24;

  @override
  Level read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Level(
      id: fields[1] as String,
      name: fields[0] as String,
      students: (fields[3] as List)?.cast<Student>(),
      speciality: fields[2] as Speciality,
    )..attendance = (fields[4] as List)?.cast<Attendance>();
  }

  @override
  void write(BinaryWriter writer, Level obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.speciality)
      ..writeByte(3)
      ..write(obj.students)
      ..writeByte(4)
      ..write(obj.attendance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecialityAdapter extends TypeAdapter<Speciality> {
  @override
  final int typeId = 25;

  @override
  Speciality read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Speciality(
      id: fields[1] as String,
      name: fields[0] as String,
      department: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Speciality obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.department);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 26;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      fullName: fields[0] as String,
      id: fields[1] as String,
      remark: fields[2] as String,
      present: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.remark)
      ..writeByte(3)
      ..write(obj.present);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
