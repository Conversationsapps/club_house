import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_profile/profile_image.dart';


class ImageProfilePreference{
  static late SharedPreferences _sharedPreferences;
  static const _keyImg = 'imgProfile';

  static ProfileImage imageProfilePreference = ProfileImage(
      imagePath: "https://images.unsplash.com/photo-1676896007103-7d8b546f8899?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=745&q=80",
  );
  static Future init()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future setProfileImg(ProfileImage userProfile)async{
    final json = jsonEncode(userProfile.toJson());
    await _sharedPreferences.setString(_keyImg, json);
  }
  static ProfileImage getProfileImg(){
    final json = _sharedPreferences.getString(_keyImg);
    return json == null ? imageProfilePreference: ProfileImage.fromJson(jsonDecode(json));
  }

}