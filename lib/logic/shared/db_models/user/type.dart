import 'package:hive/hive.dart';
part 'type.g.dart';

@HiveType(typeId: 33)
enum UserType {
  @HiveField(0)
  Student,
  @HiveField(1)
  Lecturer,
}
