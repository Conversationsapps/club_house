import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:club_house/repository/login/login_repository.dart';
import 'package:club_house/res/routes/routes_name.dart';
import 'package:club_house/utils/utils.dart';
import 'package:club_house/view_models/controllers/user_prefrence/user_prefrences_view_model.dart';

class LoginController extends GetxController {
  final _api = LoginRepository();
  UserPrefrences userPrefrences = UserPrefrences();
  final emailController = TextEditingController().obs;

  //final passwordController = TextEditingController().obs;

  final emailFocus = FocusNode().obs;

  //final passwordFocus = FocusNode().obs;
  RxBool isLoading = false.obs;

  void loginApi() {
    isLoading.value = true;
    Map data = {
      "email": emailController.value.text.trim(),
      'mobile_num': "",
    };
    _api.loginApi(data).then((value) {
      isLoading.value = false;
      if (kDebugMode) {
        print("MEss ${value.message}");
      }
      if (value.message == 'responseMessage'.tr || value.message == 'please verify login with verfication code.') {
        Utils.snackBar('login'.tr, 'loginSuccessfully'.tr);
        String userId = value.data!.identity!.low.toString();
        if (kDebugMode) {
          print("USER'S ID $userId");
          print("login message ${value.message}");
        }
        Get.toNamed(RoutesName.verificationView, arguments: [
          {"userId": userId},
          {"email": emailController.value.text},
          {"from": 'login'},
        ]);
        Get.delete<LoginController>();
      } else {
        Utils.snackBar('login'.tr, value.message.toString());
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Utils.snackBar('Error', error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
