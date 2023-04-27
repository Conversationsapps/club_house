import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:club_house/data/app_exceptions.dart';
import 'package:club_house/res/assets/image_asstes.dart';
import 'package:club_house/res/components/general_exception_widdget.dart';
import 'package:club_house/utils/utils.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/internet_exception_widdget.dart';
import '../../view_models/services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    splashService.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        //body: const InternetExceptionWidget(),
        body: Center(
          child: Text(
            'welcome'.tr,
            style: const TextStyle(color: AppColor.whiteColor, fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
