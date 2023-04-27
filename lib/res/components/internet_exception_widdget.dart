import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:club_house/res/colors/app_color.dart';
import 'package:club_house/res/components/round_button.dart';

class InternetExceptionWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const InternetExceptionWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SizedBox(height: height * .15),
          Icon(
            Icons.cloud_off,
            color: AppColor.redColor,
            size: height * .1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                'internet_exception'.tr,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: height * .1,
          ),
          RoundButton(title: 'Retry', onPress: (){
            onPressed;
          },),
        ],
      ),
    );
  }
}
