import 'dart:convert';
import 'dart:ffi';

import 'package:club_house/view_models/controllers/Profile/update_profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../models/otp/otp_response_model.dart';
import '../../../repository/user_profile/profile_repo.dart';
import '../../../utils/utils.dart';
import '../user_prefrence/user_prefrences_view_model.dart';

class GetUserProfileController extends GetxController{
  UserPrefrences userPrefrence = UserPrefrences();

  //UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  final _api = ProfileRepository();
  dynamic argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  RxString stateName = ''.obs;
  RxString countryName = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString fName = ''.obs;
  RxString id = ''.obs;
  RxString about = ''.obs;
  RxString lName = ''.obs;
  RxString dob = ''.obs;
  RxString city = ''.obs;
  RxString country = ''.obs;
  RxString gender = ''.obs;
  RxString occupation = ''.obs;
  RxString instagram = 'Add Instagram'.obs;
  RxString club1 = ''.obs;
  RxString club2 = ''.obs;
  RxString twitterUserName = 'Add Twitter'.obs;

  static final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: 'lVDnoFckT9svgJOebJFcq7soz',
    consumerSecret: '3GcLyAzXMoytULOffpeVqzAuVSHw7tYWRB1V8gEc0K1cn6DgOx',
  );

  @override
  void onInit() {
    try {
      if (kDebugMode) {
        print('argumentData ${argumentData[0]['userId']}');
        print('argumentData ${argumentData[1]['email']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    super.onInit();
  }
  String _message = 'Logged out.';
  late String newMessage;


  void login(var username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('username $username');
    if (username != 'Add Twitter') {
      try {
        await launchUrlString('twitter://', mode: LaunchMode.externalApplication);
        print('launchUrlString $launchUrlString');
        print('nativeurl https://www.twitter.com');
      } catch (e) {
        print(e);
        await launchUrlString('https://www.twitter.com', mode: LaunchMode.platformDefault);
        print('weburl https://www.twitter.com');
      }
    }
    else {
      final TwitterLoginResult result = await twitterLogin.authorize();
      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          newMessage = 'Logged in! username: ${result.session.username}';
          twitterUserName.value = result.session.username;
         // updateProfileController.updateProfileApi('');
          UpdateProfileController().updateProfileApi("twitter", result.session.username.toString());
          print("Updating Update Profile with Twitter User Name.......................... ${twitterUserName.value}");
         // updateProfileController.updateProfileApi("");
         // print("After Updating  Profile with Twitter User Name.......................... ${updateProfileController.twitter_username.value}");

          pref.setString('twitterName', twitterUserName.value);
          print("Printing Twitter Name from Get User Controller  ${twitterUserName.value}");
          try {
            await launchUrlString('twitter://', mode: LaunchMode.externalApplication);
            print('launchUrlString $launchUrlString');
            print('nativeurl https://www.twitter.com');
            //UpdateProfileController().updateProfileApi("twitter", result.session.username.toString());
            //updateProfileController.updateProfileApi('');
          } catch (e) {
            print(e);
            await launchUrlString('https://www.twitter.com', mode: LaunchMode.platformDefault);
            print('weburl https://www.twitter.com');
           // UpdateProfileController().updateProfileApi("twitter", result.session.username.toString());
            //updateProfileController.updateProfileApi('');
          }
          print('UserName ${result.session.username}');
          break;
        case TwitterLoginStatus.cancelledByUser:
          newMessage = 'Login cancelled by user.';
          print('Login cancelled by user.');
          break;
        case TwitterLoginStatus.error:
          newMessage = 'Login error: ${result.errorMessage}';
          print('Login error: ${result.errorMessage}');
          break;
      }
    }
  }

  Future<void> _launchInMobileOrBrowser(var weburl, var nativeurl)async{
    print("running _launchInMobileOrBrowser.............");
    try {
      await launchUrlString(nativeurl, mode: LaunchMode.externalApplication);
      print('launchUrlString $launchUrlString');
      print('nativeurl $nativeurl');
    } catch (e) {
      print(e);
      await launchUrlString(weburl, mode: LaunchMode.platformDefault);
      print('weburl $weburl');
    }
}

  // void getUserProfileAPI2()async{
  //   isLoading.value = true;
  //   String? userId;
  //   Future usd = userPrefrence.getUser();
  //   usd.then((value){
  //    OTPResponseModel userInfo = OTPResponseModel();
  //     userInfo = value;
  //     print("++++++++++++++++++++++++++++++++++++++++++++ $value");
  //     //adding comment
  //     userId = userInfo.data!.identity!.low.toString();
  //     print("PRINTING USER ID FROM GET USER PROFILE CONTROLLER 2 $userId");
  //     _api.getUserProfileApi(userId).then((response)async{
  //       print("userGetINFO $response");
  //       isLoading.value = false;
  //       if (kDebugMode){
  //         print("mess 2 ${response.message}");
  //         print("data 2 ${response.data}");
  //       }
  //       if(response.message == "User and location and clubs."){
  //         print("Successfully Updated Profile");
  //         print("PRINTING RESPONSE $response");
  //         SharedPreferences sp = await SharedPreferences.getInstance();
  //         //sp.setString('userId', response.data.userProfile.single.properties.userId.low as String);
  //         sp.setString('firstName', response.data.userProfile.first.properties.fName);
  //         sp.setString('lastName', response.data.userProfile.first.properties.lName);
  //         sp.setString('instagram', response.data.userProfile.first.properties.instagramUsername);
  //         sp.setString('twitter', response.data.userProfile.first.properties.twitterUsername);
  //         sp.setString('gender', response.data.userProfile.first.properties.gender);
  //         sp.setString('occupation', response.data.userProfile.first.properties.occupation);
  //         sp.setString('about', response.data.userProfile.first.properties.about);
  //         sp.setString('dob', response.data.userProfile.first.properties.dob);
  //         sp.setString('country', response.data.location.first.properties.country);
  //         sp.setString('city', response.data.location.first.properties.city);
  //         // sp.setString('club1', response.data.clubs[0]);
  //         // sp.setString('club2', response.data.clubs[1]);

  //         //id.value = sp.getString('userId').toString();
  //         fName.value = sp.getString('firstName').toString();
  //         lName.value = sp.getString('lastName').toString();
  //         instagram.value = sp.getString('instagram').toString();
  //         twitterUserName.value = sp.getString('twitter').toString();
  //         gender.value = sp.getString('gender').toString();
  //         occupation.value = sp.getString('occupation').toString();
  //         about.value = sp.getString('about').toString();
  //         dob.value = sp.getString('dob').toString();
  //         country.value = sp.getString('country').toString();
  //         city.value = sp.getString('city').toString();
  //         // club1.value = sp.getString('club1').toString();
  //         // club2.value = sp.getString('club2').toString();
  //
  //         //print("store user ${sp.getString('userId')}");
  //         print("store user ${sp.getString('firstName')}");
  //         print("store user ${sp.getString('lastName')}");
  //         print("store user ${sp.getString('instagram')}");
  //         print("store user ${sp.getString('twitter')}");
  //         print("store user ${sp.getString('gender')}");
  //         print("store user ${sp.getString('about')}");
  //         print("store user ${sp.getString('dob')}");
  //         print("store user ${sp.getString('country')}");
  //         print("store user ${sp.getString('city')}");
  //         // print("store user ${sp.getString('club1')}");
  //         // print("store user ${sp.getString('club2')}");
  //
  //
  //       }
  //
  //     });
  //
  //   });
  //
  //
  // }

  void getUserProfileAPI()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("hello========================");
    List<dynamic> users = [];
    isLoading.value = true;
    String? userId;
    Future usd = userPrefrence.getUser();
    usd.then((value){
      OTPResponseModel userInfo = OTPResponseModel();
      userInfo = value;
      print("++++++++++++++++++++++++++++++++++++++++++++ $value");
      //adding comment
      userId = userInfo.data!.identity!.low.toString();
      String? registerID =  preferences.getString("registerID");
      print("PRINTING USER ID FROM GET USER PROFILE CONTROLLER $userId");
      print("PRINTING registerID FROM GET USER PROFILE CONTROLLER $registerID");
      _api.getUserProfileApi2("$userId").then((value) async{
        print("userGetINFO $value");
        isLoading.value = false;
        if (kDebugMode){
          print("mess ${value['message']}");
          print("mess ${value["data"]}");
        }
        // print("Printing data values from Update Profile Controller $data");
        if(value["message"] == "User and location and clubs." || value["status"] == true) {

          print("Successfully Updated Profile");
          print("PRINTING RESPONSE $value");
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('userId', value!['data']['UserProfile'][0]['properties']['user_id']['low'].toString());
          sp.setString('firstName', value!['data']['UserProfile'][0]['properties']['f_name']);
          sp.setString('lastName', value!['data']['UserProfile'][0]['properties']['l_name']);
          sp.setString('userName', value!['data']['UserProfile'][0]['properties']['user_name']);
          sp.setString('twitter', value!['data']['UserProfile'][0]['properties']['twitter_username']);
          sp.setString('instagram', value!['data']['UserProfile'][0]['properties']['instagram_username']);
          sp.setString('gender', value!['data']['UserProfile'][0]['properties']['gender']);
          sp.setString('occupation', value!['data']['UserProfile'][0]['properties']['occupation']);
          sp.setString('country', value!['data']['Location'][0]['properties']['country']);
          sp.setString('city', value!['data']['Location'][0]['properties']['city']);
          sp.setString('about', value!['data']['UserProfile'][0]['properties']['about']);
          sp.setString('dob', value!['data']['UserProfile'][0]['properties']['dob']);
          sp.setString('clubs', value!['data']['clubs'][0]['properties']['club_name']);

          try{
            if(value!['data']['clubs'][1]['properties']['club_name'] != null || value!['data']['clubs'][1]['properties']['club_name'] != "" ){
              sp.setString('club2', value!['data']['clubs'][1]['properties']['club_name']);
            }
          }catch(e){
            e.printError();
          }
          id.value = sp.getString('userId').toString();
          lName.value = sp.getString('lastName').toString();
          fName.value = sp.getString('firstName').toString();

          if(fName.value.isEmpty || fName.value == null){
            print("===========user namre from get profile ${value!['data']['UserProfile'][0]['properties']['user_name']}");
            fName.value = value!['data']['UserProfile'][0]['properties']['user_name'];
          }

          occupation.value = sp.getString('occupation').toString();
          gender.value = sp.getString('gender').toString();
          about.value = sp.getString('about').toString();

          twitterUserName.value = sp.getString('twitter').toString();
          if(twitterUserName.value.isEmpty || twitterUserName.value == null || twitterUserName.value == 'null'){
            twitterUserName.value = "Add Twitter";
          }

          instagram.value = sp.getString('instagram').toString();
          if(instagram.value.isEmpty || instagram.value == null || instagram.value == 'null'){
            instagram.value = "Add instagram";
          }

          city.value = sp.getString('city').toString();
          country.value = sp.getString('country').toString();

          dob.value = sp.getString('dob').toString();
          club1.value = sp.getString('clubs').toString();

          try{
            if(value!['data']['clubs'][1]['properties']['club_name'] != null || value!['data']['clubs'][1]['properties']['club_name'] != "" ){
              club2.value = sp.getString('club2').toString();
            }else{
              club2.value = "";
            }

            if(value!['data']['UserProfile'][0]['properties']['instagram_username'] == null || value!['data']['UserProfile'][0]['properties']['instagram_username']== ""){
              instagram.value = "Add Instagram";
            }

            if(value!['data']['UserProfile'][0]['properties']['twitter_username'] == null || value!['data']['UserProfile'][0]['properties']['twitter_username'] == ""){
              twitterUserName.value = "Add Twitter";
            }

            // if(twitterUserName.value.isEmpty || twitterUserName.value == null){
            //   twitterUserName.value = "Add Twitter";
            // }else{
            //   print("===========user twitterUserName from get profile ${value!['data']['UserProfile'][0]['properties']['twitter_username']}");
            //   twitterUserName.value =value!['data']['UserProfile'][0]['properties']['twitter_username'];
            // }
          }catch(e){

          }
          //fName.value = 'ROOP';
          print("store user ${sp.getString('userId')}");
          print("store user ${sp.getString('firstName')}");
          print("store user ${sp.getString('lastName')}");
          print("store user ${sp.getString('gender')}");
          print("store user ${sp.getString('occupation')}");
          print("store user ${sp.getString('about')}");
          print("store user ${sp.getString('dob')}");
          print("store user ${sp.getString('country')}");
          print("store user ${sp.getString('city')}");
          print("store user ${sp.getString('instagram')}");
          print("store user ${sp.getString('twitter')}");

          print("store user Clubs ${sp.getString('clubs')}");
         // print("store user Clubs2 ${sp.getString('clubs2')}");

          //userPrefrence.setUserProfileInfo(value);
          print("userPrefrence.setUserProfileInfo(value) ${userPrefrence.setUserProfileInfo(value).toString()}");
          Utils.snackBar('Bravo! CCCCCCCCCCVVVVVVVVVVVVVV', value.message.toString());
          print('Bravo! User Status  ${value.status}');
          //print('printing sharedPreference user info ${userPrefrence.getUserProfileInfo()}');
        } else {
          print("Profile Updated Failed");
          Utils.snackBar('Error', value.message.toString());
        }

      }).onError(
              (error, stackTrace){
            isLoading.value = false;
            //Utils.snackBar('Error FROM Update Profile Controller', error.toString());
            if (kDebugMode) {
              print('Error FROM Print Method Update Profile Controller $error');
            }
          });
    });

  }
}