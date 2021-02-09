import "package:hive/hive.dart";
import 'package:flutter/material.dart';
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
  String password;
  @HiveField(4)
  String email;
  @HiveField(5)
  String phone;
  @HiveField(6)
  final UserType accountType;
  @HiveField(7)
  final DateTime loginDate;
  User(
      {@required this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.password,
      @required this.accountType,
      @required this.loginDate,
      this.phone,
      this.email});
}
