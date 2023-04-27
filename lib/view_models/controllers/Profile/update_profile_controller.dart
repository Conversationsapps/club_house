import 'dart:convert';

import 'package:club_house/models/user_profile/update_profile_model.dart';
import 'package:club_house/view_models/controllers/Profile/addUserLocation_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user_profile/update_user_profile_response_model.dart';
import '../../../repository/user_profile/profile_repo.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import 'package:http/http.dart' as http;
import '../user_prefrence/user_prefrences_view_model.dart';
import 'get_user_profile_controller.dart';

class UpdateProfileController extends GetxController {
  UserPrefrences userPrefrence = UserPrefrences();
  AddLocationController locationController = Get.put(AddLocationController());
  GetUserProfileController userProfileController = Get.put(GetUserProfileController());
  final _api = ProfileRepository();
  dynamic argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  RxString stateName = ''.obs;
  RxString f_Name = ''.obs;
  RxString l_Name = ''.obs;
  RxString occupationservice = ''.obs;
  RxString instagram_username = ''.obs;
  RxString twitter_username = ''.obs;
  RxString gender = ''.obs;
  RxString about = ''.obs;
  RxString dob = ''.obs;
  RxString countryName = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString userId = ''.obs;
  String state = '';
  RxString city = ''.obs;

  final f_nameController = TextEditingController().obs;
  final l_nameController = TextEditingController().obs;
  final dobController = TextEditingController().obs;
  final aboutController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  final occupationserviceController = TextEditingController().obs;

  @override
  void onInit() {
    try {
      if (kDebugMode) {
        print('argumentData ${argumentData[0]['userId']}');
        print(">>>>>>>>>>>>>>>>>>>>>>>>userId ");
        print('argumentData ${argumentData[1]['email']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    super.onInit();
  }

  // Future<List<dynamic>> fetchUsers() async {
  //   var result =
  //   await http.get(Uri.parse(
  //       "https://social-backend-377617.uw.r.appspot.com/conversation/user/get_user_profile/user_id=115"));
  //   print("<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>> ${jsonDecode(result.body)['data']}");
  //   if (result.statusCode == 200) {
  //     print("f_name <<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>> ${jsonDecode(result.body)['f_name']}");
  //     print("l_name <<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>> ${jsonDecode(result.body)['l_name']}");
  //     print("gender <<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>> ${jsonDecode(result.body)['gender']}");
  //     // If the call to the server was successful, parse the JSON
  //     var lst = result.body as List;
  //
  //     return lst.map((d) => UpdateUserProfileModel.fromJson(d)).toList();
  //   } else {
  //     // If that call was not successful, throw an error.
  //     throw Exception('Failed to load Data');
  //   }
  //
  // }

  //called during profile update at registration only

  void updateProfileApi(String from, String? username) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    UpdateUserProfileResponseModel userProfileResponseModel = UpdateUserProfileResponseModel();
    String userId = preferences.getString('userId').toString();

    print("Printing registerID in Update Profile   $userId");
    print("USER-ID $userId");

    String userID = preferences.getString('UserIdV').toString();
    //print('>>>>>>>>>>>>>>>>>>>>>>>>userId  ${argumentData[0]['userId']}');
    isLoading.value = true;
    Map data ;
    if(from == 'Instagram') {
      data = {
        "user_id": userID,
        "l_name" : preferences.getString('lastName').toString(),
        "f_name" : preferences.getString('firstName').toString(),
        "dob" : preferences.getString('dob').toString(),
        "about" : preferences.getString('about').toString(),
        "gender" : preferences.getString('gender').toString(),
        "country" : preferences.getString('country').toString(),
        "city" : preferences.getString('city').toString(),
        "occupation" : preferences.getString('occupation').toString(),
        "twitter_username" : preferences.getString('twitter').toString(),
        "instagram_username" : username.toString(),
      };
    } else if(from == 'twitter') {
      data = {
        "user_id": userID,
        "l_name" : preferences.getString('lastName').toString(),
        "f_name" : preferences.getString('firstName').toString(),
        "dob" : preferences.getString('dob').toString(),
        "about" : preferences.getString('about').toString(),
        "gender" : preferences.getString('gender').toString(),
        "country" : preferences.getString('country').toString(),
        "city" : preferences.getString('city').toString(),
        "occupation" : preferences.getString('occupation').toString(),
        "twitter_username" : username.toString(),
        "instagram_username" : preferences.getString('instagram').toString(),
      };
    } else {
      data = {
        "user_id": userID,
        "dob": dobController.value.text,
        "about": aboutController.value.text,
        "f_name": f_nameController.value.text,
        "l_name": l_nameController.value.text,
        "gender": genderController.value.text,
        "country": userProfileController.country.value,
        "city": userProfileController.city.value,
        "occupation": occupationserviceController.value.text,
        "twitter_username": userProfileController.twitterUserName.value.toString(),
        "instagram_username": userProfileController.instagram.value.toString()
      };
    }
    _api.updateUserProfileApi(data).then((value) async {
      isLoading.value = false;
      if (kDebugMode) {
        print("mess ${value.message}");
      }
      print("Printing data values from Update Profile Controller $data");
      if (value.message == "user profile is updated." || value.status == true) {
        userProfileController.about.value = aboutController.value.text;
        userProfileController.fName.value = f_nameController.value.text;
        userProfileController.lName.value = l_nameController.value.text;
        userProfileController.occupation.value = occupationserviceController.value.text;
        userProfileController.gender.value = genderController.value.text;
        userProfileController.dob.value = dobController.value.text;
        userProfileController.getUserProfileAPI();

        print("Successfully Updated Profile");
        print('value.data!.properties!.dob! ${value.data!.properties!.dob!}');
        print("PRINTING RESPONSE $value");
        print(
            "PRINTING CITY CONTROLLER VALUE+++++++++++++++++++++++++ ${locationController.stateName.value}");
        print("state  ${state.toString()}");
        userPrefrence.saveUserProfile(value);
        print("Printing Pref Data ${preferences}");


        print("Printing userProfileController.about.value  from Update Profile Controller  ${userProfileController.about.value}");
        print("Printing userProfileController.fName.value  from Update Profile Controller  ${userProfileController.fName.value}");
        print("Printing userProfileController.lName.value  from Update Profile Controller  ${userProfileController.lName.value}");
        print("Printing userProfileController.occupation.value  from Update Profile Controller  ${userProfileController.occupation.value}");
        print("Printing userProfileController.dob.value  from Update Profile Controller  ${userProfileController.dob.value}");
        print("Printing userProfileController.gender.value  from Update Profile Controller  ${userProfileController.gender.value}");


        //userPrefrence.getUserProfile();
        //just  lss

        print('Update About ${value.data!.properties!.about!}');

        f_nameController.value.text = value.data!.properties!.fName!; //sp.getString('firstName').toString();
        l_nameController.value.text = value.data!.properties!.lName!; //sp.getString('lastName').toString();
        occupationserviceController.value.text = value.data!.properties!.occupation!; //sp.getString('occupation').toString();
        genderController.value.text = value.data!.properties!.gender!; //sp.getString('gender').toString();
        dobController.value.text = value.data!.properties!.dob!; //sp.getString('gender').toString();
        aboutController.value.text = value.data!.properties!.about!; //sp.getString('gender').toString();
        //city.value = value.data!.properties..toString(); //sp.getString('gender').toString();
        //city.value = locationController; //sp.getString('gender').toString();

        if (from == "logout") {
          userPrefrence.removeUser().then((value) {
            //Get.toNamed(RoutesName.loginScreen);
            Get.offAllNamed(RoutesName.welcomeScreen);
            userPrefrence.removeUser();
          });
        } else {
          Utils.snackBar('Bravo!', value.message.toString());
          GetUserProfileController().getUserProfileAPI();
          Get.back();
        }

        /*SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('userId', value!['data']['User']['identity']['low'].toString());
      sp.setString('firstName', value!['data']['User']['properties']['f_name']);
      sp.setString('lastName', value!['data']['User']['properties']['l_name']);
      sp.setString('instagram', value!['data']['User']['properties']['instagram_username']);
      sp.setString('gender', value!['data']['User']['properties']['gender']);
      sp.setString('occupation', value!['data']['User']['properties']['occupation']);
      sp.setString('country', value!['data']['User']['properties']['country']);
      sp.setString('city', value!['data']['User']['properties']['city']);

      fName.value = sp.getString('firstName').toString();
      lName.value = sp.getString('lastName').toString();
      occupation.value = sp.getString('occupation').toString();
      gender.value = sp.getString('gender').toString();
      city.value = sp.getString('city').toString();
      country.value = sp.getString('country').toString();*/
        // int userId = argumentData[0]['userId'];
        // String about = "";
        // String dob = "";
        // String f_name = "";
        // String l_name = "";
        // String gender = "";
        // String city = stateName.value.toString();
        // String occupationservice = "";
        // String instagram_username = "";
        //
        // preferences.setString("userId", argumentData[0]['userId']);
        // preferences.setString("about", "");
        // preferences.setString("f_name", "");
        // preferences.setString("l_name", "");
        // preferences.setString("gender", "");
        // preferences.setString("city", stateName.value.toString());
        // preferences.setString("occupationservice", "");
        // preferences.setString("instagram_username", "");
        // Get.toNamed(RoutesName.homeView);
        // print("Printing argument userId : $userId");
        // print("Printing argument dob : $dob");
        // print("Printing argument f_name : $f_name");
        // print("Printing argument l_name : $l_name");
        // print("Printing argument gender : $gender");
        // print("Printing argument city : $city");
        // print("Printing argument occupationservice : $occupationservice");
        // print("Printing argument instagram_username : $instagram_username");
        //Get.delete<UpdateProfileController>();
      } else {
        print("Profile Updated Failed");
        //Utils.snackBar('Error', value.message.toString());
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Utils.snackBar('Error FROM Update Profile Controller', error.toString());
      if (kDebugMode) {
        print('Error FROM Print Method Update Profile Controller $error');
      }
    });
  }
}
