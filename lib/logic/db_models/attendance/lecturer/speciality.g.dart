// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecialityAdapter extends TypeAdapter<Speciality> {
  @override
  final int typeId = 2;

  @override
  Speciality read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Speciality(
      name: fields[0] as String,
      department: fields[1] as String,
      id: fields[2] as String,
      levels: (fields[3] as List)?.cast<Level>(),
    );
  }

  @override
  void write(BinaryWriter writer, Speciality obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.department)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.levels);
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
