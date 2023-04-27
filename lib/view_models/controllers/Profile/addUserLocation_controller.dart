import 'dart:convert';

import 'package:club_house/repository/user_profile/profile_repo.dart';
import 'package:club_house/view_models/controllers/Profile/get_user_profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/otp/verification_response_model.dart';
import '../../../utils/utils.dart';
import '../user_prefrence/user_prefrences_view_model.dart';
import 'package:http/http.dart' as http;
import '../../../res/routes/routes_name.dart';

class AddLocationController extends GetxController{

  UserPrefrences userPrefrence = UserPrefrences();
  GetUserProfileController getUserProfileController = Get.put(GetUserProfileController());
  final _api = ProfileRepository();
  dynamic argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  RxString stateName = ''.obs;
  RxString countryName = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;


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

  Future<void> addLocationAPI() async {
    print("Entering Add Location Api Controller.............................");
    //print("argumentData[0]['userId']  ${argumentData[0]['userId']}");
    //print("Userid in AddLocation ===============  ${argumentData[0]['userId']}");

    /*String? userID;
    Future usd = userPrefrence.getVerifiedUser();
    usd.then((value) {
      VerificationResponseModel model = VerificationResponseModel();

      model.data!.identity!.low;
      print("Printing userId   ${model.data!.identity!.low}");
      userID = model.data!.identity!.low.toString();
    });*/
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userID = preferences.getString('UserIdV').toString();
    isLoading.value = true;
    try {
      var url = Uri.parse('https://social-backend-377617.uw.r.appspot.com/conversation/user/add_user_location');
      //String userId = preferences.getString('userId').toString();
      //VerificationResponseModel model = VerificationResponseModel();

      print("Printing stateName   ${stateName.value.toString()}");
      print("Printing country   ${countryName.value.toString()}");
      print("Printing latitude   ${latitude.value.toString()}");
      print("Printing latitude   ${longitude.value.toString()}");

      Map body = {
          "user_id": userID,
          "user_latitude": latitude.value.toString(),
          "user_longitude": longitude.value.toString(),
          "user_city": stateName.value.toString(),
          "user_country": countryName.value.toString(),
      };

      print("pass body from addLocationAPI ${body.toString()}");
      http.Response response = await http.post(url, body: jsonEncode(body), headers:{
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },);
      print("response.statusCode ${response.statusCode}");
      print("Response from add location url ${response.body}");
      print("Info From add location Url $url");
      print(response.body.toString());
      try{
        if (response.statusCode == 200) {

          SharedPreferences sp = await SharedPreferences.getInstance();
          //sp.setString('city', addLocationController.stateName.value);
          isLoading.value = false;
          print("State Name Name Name  $stateName");
          print("State Name Name Name Value  ${stateName.value}");
          print("Response after 200 from url in addLocation API ${response.body}");
          print("Info From 200 response  Url in addLocation API $url");
          print("pass body 2 from addLocationAPI ${body.toString()}");

          print("response.statusCode ${response.statusCode}");
          Utils.snackBar('Bravo!', '${jsonDecode(response.body)['message']}');
          print('Status message ${jsonDecode(response.body)['status']}');

          //Get.toNamed(RoutesName.mainPage);
        }else{
          isLoading.value = false;
          Utils.snackBar('Error', '${jsonDecode(response.body)['message']}');
          print('else message ${jsonDecode(response.body)['message']}');
          /*showDialog(context: Get.context!, builder: (context){
            return SimpleDialog(
              title: const Text("Error"),
              contentPadding: const EdgeInsets.all(AppPadding.p20,),
              children: [Text(jsonDecode(response.body)['message'] ?? "Unknown Error Occurred")],
            );
          });*/
          //throw UserRegistrationResponse.fromJson(jsonDecode(response.body)[''message'']);
          throw jsonDecode(response.body)['message'] ?? "Unknown Error Occurred";
        }

      }catch(e){
        isLoading.value = false;
        print('catch message ${jsonDecode(response.body)['message']}');
        print('Status message ${jsonDecode(response.body)['status']}');
       // String user_id = "${jsonDecode(response.body)['data']['identity']['low'] as int}";
       // print('User Id from Json Object  $user_id');

        /*showDialog(context: Get.context!, builder: (context){
          return SimpleDialog(
            title: const Text("Error"),
            contentPadding: const EdgeInsets.all(AppPadding.p20,),
            children: [Text(jsonDecode(response.body)['message'] ?? "Unknown Error Occurred")],
          );
        });*/

      }

    }catch(e){
      isLoading.value = false;
      //Get.back();
      e.printError();
    }
  }









  // called during profile update at registration only
  // void updateProfileApiAtRegistration(){
  //   isLoading.value = true;
  //   Map data = {
  //     "user_id":argumentData[0]['userId'],
  //     "about":"",
  //     "dob":"",
  //     "f_name":"",
  //     "l_name":"",
  //     "gender":"",
  //     "city":stateName.value.toString(),
  //     "occupationservice":"",
  //     "instagram_username":""
  //   };
  //   _api.updateProfileApi(data).then((value) async{
  //     isLoading.value = false;
  //     if (kDebugMode) {
  //       print("mess ${value.message}");
  //     }
  //     print("Printing data values from Update Profile Controller $data");
  //     if(value.message == "user profile is updated." || value.status == true) {
  //       print("Successfully Updated Profile");
  //       userPrefrence.saveUserProfile(value);
  //       Utils.snackBar('Bravo!', value.message.toString());
  //       // int userId = argumentData[0]['userId'];
  //       // String about = "";
  //       // String dob = "";
  //       // String f_name = "";
  //       // String l_name = "";
  //       // String gender = "";
  //       // String city = stateName.value.toString();
  //       // String occupationservice = "";
  //       // String instagram_username = "";
  //       //
  //       // preferences.setString("userId", argumentData[0]['userId']);
  //       // preferences.setString("about", "");
  //       // preferences.setString("f_name", "");
  //       // preferences.setString("l_name", "");
  //       // preferences.setString("gender", "");
  //       // preferences.setString("city", stateName.value.toString());
  //       // preferences.setString("occupationservice", "");
  //       // preferences.setString("instagram_username", "");
  //        Get.toNamed(RoutesName.homeView);
  //       // print("Printing argument userId : $userId");
  //       // print("Printing argument dob : $dob");
  //       // print("Printing argument f_name : $f_name");
  //       // print("Printing argument l_name : $l_name");
  //       // print("Printing argument gender : $gender");
  //       // print("Printing argument city : $city");
  //       // print("Printing argument occupationservice : $occupationservice");
  //       // print("Printing argument instagram_username : $instagram_username");
  //       //Get.delete<UpdateProfileController>();
  //     } else {
  //       print("Profile Updated Failed");
  //       Utils.snackBar('Error', value.message.toString());
  //     }
  //
  //   }).onError(
  //           (error, stackTrace){
  //         isLoading.value = false;
  //         Utils.snackBar('Error FROM Update Profile Controller', error.toString());
  //         if (kDebugMode) {
  //           print('Error FROM Print Method Update Profile Controller $error');
  //         }
  //       });
  // }
  //

  // called during profile update at registration only
  // void updateProfileApi() {
  //   isLoading.value = true;
  //   Map data = {
  //     "user_id":"123",
  //     "about":"about.value.text",
  //     "dob":"dob.value.text",
  //     "f_name":"f_name.value.text",
  //     "l_name":"l_name.value.text",
  //     "gender":"gender.value.text",
  //     "city":stateName.value.toString(),
  //     "occupationservice":"occupationservice.value.text",
  //     "instagram_username":"instagram_username.value.text"
  //   };
  //   _api.addUserLocationApi(data).then((value) {
  //     isLoading.value = false;
  //     if (kDebugMode) {
  //       print("mess ${value.message}");
  //     }
  //     print("Printing data values from Update Location Controller $data");
  //
  //     if(value.message == "user profile is updated." || value.status == true) {
  //       print("Successfully Added Location");
  //       Utils.snackBar('Bravo!', value.message.toString());
  //       int userId = argumentData[0]['userId'];
  //       String about = "";
  //       String dob = "";
  //       String f_name = "";
  //       String l_name = "";
  //       String gender = "";
  //       String city = stateName.value.toString();
  //       String occupationservice = "";
  //       String instagram_username = "";
  //       Get.toNamed(RoutesName.homeView, arguments: [
  //         {"userId": userId},
  //         {"about": about},
  //         {"dob": dob},
  //         {"f_name": f_name},
  //         {"l_name": l_name},
  //         {"gender": gender},
  //         {"city":city},
  //         {"occupationservice":occupationservice},
  //         {"instagram_username":instagram_username}
  //       ]);
  //       print("Printing argument userId : $userId");
  //       print("Printing argument dob : $dob");
  //       print("Printing argument f_name : $f_name");
  //       print("Printing argument l_name : $l_name");
  //       print("Printing argument gender : $gender");
  //       print("Printing argument city : $city");
  //       print("Printing argument occupationservice : $occupationservice");
  //       print("Printing argument instagram_username : $instagram_username");
  //        Get.delete<AddLocationController>();
  //     } else {
  //       print("Profile Updated Failed");
  //       Utils.snackBar('Error', value.message.toString());
  //     }
  //
  //   }).onError(
  //           (error, stackTrace){
  //         isLoading.value = false;
  //         Utils.snackBar('Error FROM Update Profile Controller', error.toString());
  //         if (kDebugMode) {
  //           print('Error FROM Print Method Update Profile Controller $error');
  //         }
  //       });
  // }





}