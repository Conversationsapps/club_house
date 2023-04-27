import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/user_profile/profile_repo.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../user_prefrence/user_prefrences_view_model.dart';

class DeleteUserProfileController extends GetxController{
  UserPrefrences userPreference = UserPrefrences();
  final _api = ProfileRepository();
  dynamic argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  RxString stateName = ''.obs;
  RxString countryName = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString userId = ''.obs;


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




  //called during profile update at registration only
  void deleteUserProfileApi()async{
    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId').toString();
    Map data = {
      "user_id":userId,
    };
    print("delete profile user_id $userId");
    _api.deleteUserProfileApi(data).then((value) async{
      isLoading.value = false;
      if (kDebugMode) {
        print("mess ${value.message}");
      }
      print("Printing data values from delete Profile Controller $data");
      if(value.message == "user deleted." || value.status == true) {
        print("Successfully Deleted Profile");
        print("PRINTING RESPONSE $value");
        userPreference.removeUser();
        userPreference.deleteUserProfileInfo(value);


        Utils.snackBar('Bravo!', value.message.toString());
        // int userId = argumentData[0]['userId'];
        // preferences.setString("userId", argumentData[0]['userId']);
         Get.toNamed(RoutesName.loginScreen);
        // print("Printing argument userId : $userId");

        //Get.delete<UpdateProfileController>();
      } else {
        print("Profile Deleted Failed");
        Utils.snackBar('Error', value.message.toString());
      }

    }).onError(
            (error, stackTrace){
          isLoading.value = false;
          Utils.snackBar('Error FROM Update Profile Controller', error.toString());
          if (kDebugMode) {
            print('Error FROM Print Method Update Profile Controller $error');
          }
        });
  }
}