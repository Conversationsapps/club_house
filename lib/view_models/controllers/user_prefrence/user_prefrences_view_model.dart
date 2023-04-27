
import 'dart:convert';

import 'package:club_house/models/location/AddLocationModel.dart';
import 'package:club_house/models/login/user_resposne_model.dart';
import 'package:club_house/models/otp/otp_response_model.dart';
import 'package:club_house/models/otp/verification_response_model.dart';
import 'package:club_house/models/user_profile/get_user_profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_profile/delete_user_response.dart';
import '../../../models/user_profile/update_user_profile_response_model.dart';

class UserPrefrences {

  /*Future<bool> saveUser(OTPResponseModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userData', jsonEncode(responseModel));
    print('setUserData $sp');
    *//*sp.setString('userId', responseModel.data!.identity!.low.toString());
    sp.setString('email', responseModel.data!.properties!.email.toString());
    sp.setString('username', responseModel.data!.properties!.userName.toString());
    sp.setString('token', responseModel.data!.properties!.token.toString());*//*
    return true;
  }
*/
  Future<OTPResponseModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userData = sp.getString('userData');
    Map<String,dynamic> userMap = jsonDecode(userData!) as Map<String, dynamic>;
    print('getUserData $userMap');
/*    String? email = sp.getString('email');
    int? username = sp.getInt('username');
    int? token = sp.getInt('token');*/
    return OTPResponseModel.fromJson(userMap);
  }

  Future<bool> saveVerifiedUser(VerificationResponseModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //sp.setString('verifiedUserData', jsonEncode(responseModel));
    sp.setString('userData', jsonEncode(responseModel));
    print('setVerifiedUserData $sp');
    /*sp.setString('userId', responseModel.data!.identity!.low.toString());
    sp.setString('email', responseModel.data!.properties!.email.toString());
    sp.setString('username', responseModel.data!.properties!.userName.toString());
    sp.setString('token', responseModel.data!.properties!.token.toString());*/
    return true;
  }

  Future<VerificationResponseModel> getVerifiedUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userData = sp.getString('verifiedUserData');
    Map<String,dynamic> userMap = jsonDecode(userData!) as Map<String, dynamic>;
    print('getVerifiedUserData $userMap');
/*    String? email = sp.getString('email');
    int? username = sp.getInt('username');
    int? token = sp.getInt('token');*/
    return VerificationResponseModel.fromJson(userMap);
  }


  Future<bool> saveUserProfile(UpdateUserProfileResponseModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userProfileData', jsonEncode(responseModel));
    print('printing Saved........userProfileData ${sp.getString("userProfileData")}');
    /*sp.setString('userId', responseModel.data!.identity!.low.toString());
    sp.setString('email', responseModel.data!.properties!.email.toString());
    sp.setString('username', responseModel.data!.properties!.userName.toString());
    sp.setString('token', responseModel.data!.properties!.token.toString());*/
    return true;
  }


  Future<UpdateUserProfileResponseModel> getUserProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print('getUserProfile........getUserProfile ${sp.getString("userProfileData")}');
    String? userData = sp.getString('userLocationData');
    Map<String,dynamic> userMap = jsonDecode(userData!) as Map<String, dynamic>;
    print('Printing get userProfileData From Preferences $userMap');

/*    String? email = sp.getString('email');
    int? username = sp.getInt('username');
    int? token = sp.getInt('token');*/
    return UpdateUserProfileResponseModel.fromJson(userMap);
  }

  Future<bool> setUserProfileInfo(GetUserResponseModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('setProfileInfo', jsonEncode(responseModel));
    print('printing Saved........setProfileData ${sp.getString("setProfileData")}');
    /*sp.setString('userId', responseModel.data!.identity!.low.toString());
    sp.setString('email', responseModel.data!.properties!.email.toString());
    sp.setString('username', responseModel.data!.properties!.userName.toString());
    sp.setString('token', responseModel.data!.properties!.token.toString());*/
    return true;

  }
  Future<GetUserResponseModel> getUserProfileInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print('getUserProfileInfo........getUserProfileInfo ${sp.getString("setProfileInfo")}');
    String? userData = sp.getString('setProfileInfo');
    Map<String,dynamic> userMap = jsonDecode(userData!) as Map<String, dynamic>;
    print('Printing get userProfileInfo From Preferences $userMap');

/*    String? email = sp.getString('email');
    int? username = sp.getInt('username');
    int? token = sp.getInt('token');*/
    return GetUserResponseModel.fromJson(userMap);
  }
  Future<bool> deleteUserProfileInfo(DeleteUserResponseModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
   // sp.setString('setDeleteProfileInfo', jsonEncode(responseModel));
    sp.clear();
    return true;
  }



  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
