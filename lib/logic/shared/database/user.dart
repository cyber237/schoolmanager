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
    bool _lect = data["id"].toString().startsWith("l");
    await user.add(_lect
        ? new User.lecturer(
            id: data["id"],
            password: password,
            firstName: data["name"],
            lastName: data["name"],
            email: data["email"],
            loginDate: DateTime.now(),
            phone: data["phone"])
        : new User.student(
            id: data["id"],
            password: password,
            firstName: data["name"],
            lastName: data["name"],
            email: data["email"],
            phone: "680359954",
            studentInfo: new StudentInfo(
              group: data["group"],
              level: data["level"],
              speciality: data["speciality"],
            ),
            loginDate: DateTime.now(),
          ));
    debugPrint("user::${user.length}");
    await user.close();
    // await courseDB.storeCourses(data["courses"]).whenComplete(() async {

    // });
  }

  Future<User> getUser() async {
    Box users = await Hive.openBox("user");
    // TODO: Remove add user (purpose was for testing)
    if (users.isEmpty) {
      await users.add(User.lecturer(
          id: "l-iuc19ee45",
          firstName: "Nintai",
          lastName: "Dick",
          password: "popopopop",
          email: "nintaidick67@gmail.com",
          phone: "680359954",
          loginDate: DateTime.now()));
    }
    User user = users.getAt(0) as User;
    debugPrint("Box length: ${users.length}");
    await users.close();
    return user;
  }

  Future<UserType> checkUser() async {
    Box user = await Hive.openBox("user");
    debugPrint("${user.length}");
    if (user.isEmpty) {
      return null;
    }
    UserType t = user.getAt(0).accountType as UserType;
    user.close();
    return t;
  }

  Future<Map> getTTRequestData() async {
    Box user = await Hive.openBox("user");
    Map data = {
      "id": await user.getAt(0).id,
    };
    await user.close();
    return data;
  }
}
