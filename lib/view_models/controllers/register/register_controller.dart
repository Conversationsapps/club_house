import 'package:club_house/view_models/controllers/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:club_house/res/routes/routes_name.dart';
import 'package:club_house/utils/utils.dart';
import 'package:club_house/view_models/controllers/user_prefrence/user_prefrences_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/register/register_repository.dart';

class RegisterController extends GetxController {

  final _api = RegisterRepository();
  final emailController = TextEditingController().obs;
  //final passwordController = TextEditingController().obs;

  final emailFocus = FocusNode().obs;
  //final passwordFocus = FocusNode().obs;
  RxBool isLoading = false.obs;

  void registerApi()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoading.value = true;
    Map data = {
      "email": emailController.value.text.trim(),
      'mobile_num': "",
      'password': "",
      'token': "",
      'user_name': emailController.value.text.trim(),
    };
    _api.registerApi(data).then((value) {
        isLoading.value = false;
        if (kDebugMode) {
          print("mess $value['data']");
          print("only Value $value");
        }
        if(value.message == 'registerResponseMessage'.tr) {
          print("only Value and value  $value");
          print("only Value user id  ${value.data?.first.properties!.userId}");

          preferences.setString("registerID", "${value.data?.first.properties!.userId}");
          preferences.setString("registerUserName", "${value.data?.first.properties!.userName}");
          String? registerID =  preferences.getString("registerID");
          String? registerUserName =  preferences.getString("registerUserName");

          print("Printing registerID   $registerID");
          print("Printing registerUserName   $registerUserName");


          Utils.snackBar('Register'.tr, 'registerSuccessfully'.tr);
          Get.toNamed(RoutesName.verificationView, arguments: [
            // {"userId": value.data![0].identity!.low},
            {"userId": value.data?.first.properties!.userId},
            {"email": emailController.value.text},
            {"from": 'register'},
          ]);
          Get.delete<RegisterController>();
        } else {
          Utils.snackBar('Register'.tr, value.message.toString());
        }

    }).onError(
    (error, stackTrace){
    isLoading.value = false;
    Utils.snackBar('Error', error.toString());
    if (kDebugMode) {
      print('Error $error');
    }
    });
  }
}
