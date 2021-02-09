import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../db_models/user/user.dart';
import '../db_models/user/type.dart';
//import 'lecturer/attendance.dart';

class UserDB {
  Future<void> storeLoginData(Map data, String password) async {
    Box user = await Hive.openBox("user");
    //final CourseLecturerDB courseDB = new CourseLecturerDB();
    await user.clear();
    await user.add(new User(
        id: data["id"],
        password: password,
        firstName: data["name"],
        lastName: data["name"],
        email: data["email"],
        loginDate: DateTime.now(),
        accountType: data["id"].toString().startsWith("l")
            ? UserType.Lecturer
            : UserType.Student,
        phone: data["phone"]));
    debugPrint("user::${user.length}");
    await user.close();
    // await courseDB.storeCourses(data["courses"]).whenComplete(() async {

    // });
  }

  Future<UserType> checkUser() async {
    Box user = await Hive.openBox("user");
    debugPrint("${user.length}");
    if (user.isEmpty) {
      return null;
    }
    return user.getAt(0).accountType as UserType;
  }
}
