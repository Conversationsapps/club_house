import 'dart:convert';

import 'package:club_house/repository/clubs/join_clubs_repository.dart';
import 'package:club_house/repository/clubs/join_clubs_response_repository.dart';
import 'package:club_house/view_models/controllers/Profile/get_user_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../user_prefrence/user_prefrences_view_model.dart';
import 'package:http/http.dart' as http;

class JoinClubsController extends GetxController{

  final _api = JoinClubResponseRepository();
  UserPrefrences userPrefrences = UserPrefrences();
  dynamic argumentData = Get.arguments;
  List<dynamic> clubIds = [];
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    try {
      if (kDebugMode) {
        print('argumentData User Id ${argumentData[0]['userId']}');
        print('argumentData user Email ${argumentData[1]['email']}');
        print('argumentData user from ${argumentData[2]['from']}');
        print("List Of Club IDs $clubIds");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    super.onInit();
  }


  Future<void> joinClubsTesting(BuildContext context)async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoading.value = true;

    try {
      print('clubIds $clubIds');
      //print('clubIds ${argumentData[0]['userId']}');
      //var url = Uri.parse('https://social-backend-377617.uw.r.appspot.com/club/join_clubs');
      var url = Uri.parse('https://social-backend-377617.uw.r.appspot.com/club/join_clubs');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userID = preferences.getString('UserIdV').toString();
      Map body = {"club_ids": clubIds, "user_id": userID};
      print('url $url');
      print('map body $body');

      print("USER ID ID ID   $userID");

      http.Response response = await http.post(url, body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },);
      print("response.statusCode ${response.statusCode}");
      print("body of  v_code ${body['v_code']}");
      print("Response from url ${response.body}");
      print("Info From  Url $url");
      print(response.body.toString());

      try{
        if (response.statusCode == 200) {
          isLoading.value = false;
          //print(argumentData[2]['from'] == "Verification");
          print("response body 200 of  v_code ${body['v_code']}");
          print("Response after 200 from url ${response.body}");
          print("Info From 200 response  Url $url");

          // String user_id = "${jsonDecode(response.body)['data']['identity']['low'] as int}";
          // print("user_id user_id $user_id");
          print("response.statusCode ${response.statusCode}");
         // Utils.snackBar('club joined', 'club joined');
          Utils.snackBar('Bravo!', '${jsonDecode(response.body)['message']}');
          print('Status message ${jsonDecode(response.body)['status']}');
          print('Status message ${jsonDecode(response.body)['message']}');

          if(argumentData[2]['from'] == "Verification" ){
            print('from  == ${argumentData[2]['from']}');
            Get.offAllNamed(RoutesName.mainPage, arguments: [
              {"from": 'register'},
            ]);
            GetUserProfileController().getUserProfileAPI();

          }else if(argumentData[2]['from'] == "profile"){
            print('from  == ${argumentData[2]['from']}');
            GetUserProfileController().getUserProfileAPI();
            //Get.toNamed(RoutesName.profile,);
            Navigator.pop(context);
            //Get.back();
            GetUserProfileController().getUserProfileAPI();
          }
          Get.delete<JoinClubsController>();

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
        String user_id = "${jsonDecode(response.body)['data']['identity']['low'] as int}";
        print('User Id $user_id');
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


  // OTP Verification
  void joinClubs() {
    isLoading.value = true;
    Map data = {
      'club_ids': clubIds,
      'user_id': argumentData[0]['userId'].toString(),
    };
    print("Printing Data from response $data");
    _api.joinClubResponseApi(data).then((value) {
      isLoading.value = false;
      if (kDebugMode) {
        print("mess ${value.status}");
        print("mess ${value.message} ${value.status}");
      }
      if(value.message == "club joined" || value.status == true) {
        Utils.snackBar('club joined', 'club joined');
        Get.toNamed(RoutesName.clubs, arguments: [
          {"userId": argumentData[0]['userId'].toString()},
          {"email": argumentData[1]['email']}
        ]);
        Get.delete<JoinClubsController>();
      } else {
        Utils.snackBar('Failure', 'Could not Join Clubs');
      }

    }).onError(
            (error, stackTrace){
          isLoading.value = false;
          print('stackTrace $stackTrace');
          Utils.snackBar('Error From Club Controller', error.toString());
          if (kDebugMode) {
            Utils.snackBar('Error From kDebugMode Club Controller', error.toString());
            print('Error From Print Method kDebugMode Club Controller  $error');
          }
        });
  }

}