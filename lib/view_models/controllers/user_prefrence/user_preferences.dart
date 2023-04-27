import 'dart:convert';
import 'package:club_house/models/user_profile/update_profile_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference{
  static late SharedPreferences _sharedPreferences;
  dynamic argumentData = Get.arguments;
  static const _keyUser = 'user';


  static UpdateUserProfileModel myUser = UpdateUserProfileModel(
      userId: 1,
      about: "I am a Mobile developer, Working with 5+ yrs with Java and Flutter, Also a Certified Web Developer",
      dob: "23/05/2023",
      fName: "Dennis",
      lName: "Dennis",
      gender: "male",
      city: "Lagos",
      occupationservice: "Software Developer"
  );
  static Future init()async{
     _sharedPreferences = await SharedPreferences.getInstance();
  }
    static Future setUser(UpdateUserProfileModel userProfile)async{
    final json = jsonEncode(userProfile.toJson());
    await _sharedPreferences.setString(_keyUser, json);
  }
  static UpdateUserProfileModel getUser(){
    final json = _sharedPreferences.getString(_keyUser);
    return json == null ? myUser: UpdateUserProfileModel.fromJson(jsonDecode(json));
  }
}