import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/login/login_repository.dart';
import '../../../repository/otp/otp_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../user_prefrence/user_prefrences_view_model.dart';

class VerificationController extends GetxController{

  final _api = OTPRepository();
  final _apiLogin = LoginRepository();

  UserPrefrences userPrefrence = UserPrefrences();
  dynamic argumentData = Get.arguments;
  RxBool isLoading = false.obs;
  //String  userId = '', email = '';

  @override
  void onInit() {
    try {
      if (kDebugMode) {
        print('argumentData ${argumentData[0]['userId']}');
        print('argumentData ${argumentData[1]['email']}');
        print('argumentData ${argumentData[2]['from']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    super.onInit();
  }
  TextEditingController vCode = TextEditingController();
  RxString controllerText = ''.obs;

  // OTP Verification
  void verificationApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading.value = true;
    Map data = {
      'user_id': argumentData[0]['userId'].toString(),
      'v_code': vCode.value.text,
    };
    _api.verificationApi(data).then((value) {
      isLoading.value = false;
      if (kDebugMode) {
        print("mess ${value.message}");
      }
      if(value.message == 'verification code is verified and user is active now.' || value.status == true) {

        Utils.snackBar('Verification Successful', 'verification code is verified and user is active now');
        pref.setString("UserIdV", argumentData[0]['userId'].toString());
        userPrefrence.saveVerifiedUser(value);
        //userPrefrence.saveUser(value);
        if(argumentData[2]['from'] == 'login') {
          Get.offAllNamed(RoutesName.mainPage, arguments: [
            {"userId": argumentData[0]['userId'].toString()},
            {"email": argumentData[1]['email']},
          ]);
        } else {
          Get.offAllNamed(RoutesName.clubs, arguments: [
            {"userId": argumentData[0]['userId'].toString()},
            {"email": argumentData[1]['email']},
            {"from": 'Verification'}
          ]);
        }

        Get.delete<VerificationController>();
      } else {
        Utils.snackBar('Verification Controller', value.message.toString());
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

  // Resend OTP
  void resendOtpApi() {
    isLoading.value = true;
    Map data = {
      "email": argumentData[1]['email'].toString().trim(),
      'mobile_num': "",
    };
    _apiLogin.loginApi(data).then((value) {
      isLoading.value = false;
      if (kDebugMode) {
        print("MEss ${value.message}");
      }
      if(value.message == 'responseMessage'.tr) {
        Utils.snackBar('resendCode'.tr, 'responseMessage'.tr);
        String userId = value.data!.identity!.low.toString();
        if (kDebugMode) {
          print("USER'S ID $userId");
          print("login message ${value.message}");
        }
        /*Get.toNamed(RoutesName.otpView, arguments: [
          {"userId": userId},
          {"email": emailController.value.text}
        ]);*/
        //Get.delete<LoginController>();
      } else {
        Utils.snackBar('resendCode'.tr, value.message.toString());
      }

    }).onError(
            (error, stackTrace){
          isLoading.value = false;
          Utils.snackBar('Error', error.toString());
          if (kDebugMode) {
            print(error.toString());
          }
        });
  }
/*Future<void> otpVerification()async{
    isLoading.value = true;
    try {
      var url = Uri.parse(APIEndPoints.baseUrl + APIEndPoints.userEndPoint.userActivation);
      Map body = {
        'user_id': argumentData[0]['userId'].toString(),
        'v_code': v_code.value.text
      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'},
      );
      print("body of  v_code ${body['v_code']}");
      print("Response from url ${response.body}");
      print("Response from url ${response.statusCode}");
      print("Info From  Url $url");
      print("Response UserId from Registration ${argumentData[0]['userId'].toString()}");

      print("Response Message one: ${jsonDecode(response.body)['message']}");
      String errorMsg = "${jsonDecode(response.body)['message']}";

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('errorMsg', errorMsg);

      if (response.statusCode == 200) {
        isLoading.value = false;
        if(jsonDecode(response.body)['status']== true){
          v_code.clear();
          print(response.body.toString());
          print("Response UserId from Registration ${argumentData[0]['userId'].toString()}");
          print("Response Message two: ${jsonDecode(response.body)['message']}");

          controllerText.value = jsonDecode(response.body)['message'];
          update();
          // if Successful , navigate user to club screen
          Get.toNamed(Routes.clubsRoute);
        }else{
          isLoading.value = false;
          Get.snackbar('Verification Code Error', jsonDecode(response.body)['message'],backgroundColor: AppColor.primaryColorLight, colorText: AppColor.white,);
        }
      } else {
        isLoading.value = false;
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occurred";
      }
    }catch(e){
      isLoading.value = false;
      print(e.toString());
      //Get.back();
      */
/*showDialog(context: Get.context!, builder: (context){
        return SimpleDialog(
          title: const Text("Error"),
          contentPadding: const EdgeInsets.all(AppPadding.p20,),
          children: [Text(e.toString())],
        );
      });*/
/*

    }

  }

  Future<void> loginUser()async{
    isLoading.value = true;
    try {
      var url = Uri.parse(APIEndPoints.baseUrl + APIEndPoints.userEndPoint.login);
      Map body = {
        'email': argumentData[1]['email'],
        'mobile_num':"",
      };
      print('argumentData email ${argumentData[1]['email']}');
      print(body.toString());
      http.Response response = await http.post(url, body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },);
      print("body of  v_code ${body['v_code']}");
      print("Response from url ${response.body}");
      print("Info From  Url $url");
      print(response.body.toString());

      if (response.statusCode == 200) {
        isLoading.value = false;
        print("response body 200 of  v_code ${body['v_code']}");
        print("Response after 200 from url ${response.body}");
        print("Info From 200 response  Url $url");
        update();
        // if Successful , navigate user to club screen
        //Get.toNamed(Routes.mainRoute);
      }else{
        isLoading.value = false;
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occurred";
      }

    }catch(e){
      isLoading.value = false;
      //Get.back();
      showDialog(context: Get.context!, builder: (context){
        return SimpleDialog(
          title: const Text("Error"),
          contentPadding: const EdgeInsets.all(AppPadding.p20,),
          children: [Text(e.toString())],
        );
      });
    }
  }*/
}