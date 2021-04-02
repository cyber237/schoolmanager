import "package:hive/hive.dart";
import 'package:flutter/material.dart';
import 'package:schoolmanager/logic/lecturer/db_models/attendance/course.dart';
import 'type.dart';

part "user.g.dart";

@HiveType(typeId: 30)
class User extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String phone;
  @HiveField(6)
  final UserType accountType;
  @HiveField(7)
  final DateTime loginDate;
  @HiveField(8)
  StudentInfo studentInfo;
  User(
      {@required this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.password,
      @required this.email,
      @required this.phone,
      @required this.accountType,
      @required this.loginDate,
      this.studentInfo});

  User.student(
      {@required String id,
      @required String firstName,
      @required String lastName,
      @required String password,
      @required String email,
      @required String phone,
      @required StudentInfo studentInfo,
      @required DateTime loginDate})
      : this(
            id: id,
            firstName: firstName,
            lastName: lastName,
            password: password,
            email: email,
            phone: phone,
            studentInfo: studentInfo,
            loginDate: loginDate,
            accountType: UserType.Student);
  User.lecturer(
      {@required String id,
      @required String firstName,
      @required String lastName,
      @required String password,
      @required String email,
      @required String phone,
      @required DateTime loginDate})
      : this(
            id: id,
            firstName: firstName,
            lastName: lastName,
            password: password,
            email: email,
            phone: phone,
            loginDate: loginDate,
            accountType: UserType.Lecturer);
}

@HiveType(typeId: 31)
class StudentInfo extends HiveObject {
  @HiveField(0)
  final String speciality;
  @HiveField(1)
  final String level;
  @HiveField(2)
  final String group;
  StudentInfo({
    @required this.speciality,
    @required this.level,
    @required this.group,
  });
}
