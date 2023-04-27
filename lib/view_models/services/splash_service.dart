import 'dart:async';
import 'package:get/get.dart';
import 'package:club_house/res/routes/routes_name.dart';
import 'package:club_house/view_models/controllers/user_prefrence/user_prefrences_view_model.dart';

class SplashService {
  void isLogin() {
    UserPrefrences userPrefrences = UserPrefrences();
    userPrefrences.getUser().then((value) {
      Timer(
        const Duration(seconds: 3),
        () => Get.offAllNamed(RoutesName.mainPage),


      );
    }).onError((error, stackTrace) {
      Timer(const Duration(seconds: 3),
          () => Get.offAllNamed(RoutesName.welcomeScreen));
    });
  }
}
