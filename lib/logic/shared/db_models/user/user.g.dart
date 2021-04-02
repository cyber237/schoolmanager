// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 30;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      password: fields[3] as String,
      email: fields[4] as String,
      phone: fields[5] as String,
      accountType: fields[6] as UserType,
      loginDate: fields[7] as DateTime,
      studentInfo: fields[8] as StudentInfo,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.accountType)
      ..writeByte(7)
      ..write(obj.loginDate)
      ..writeByte(8)
      ..write(obj.studentInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudentInfoAdapter extends TypeAdapter<StudentInfo> {
  @override
  final int typeId = 31;

  @override
  StudentInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentInfo(
      speciality: fields[0] as String,
      level: fields[1] as String,
      group: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.speciality)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.group);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
