import 'package:club_house/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final IconData icon;

  const InputField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.icon,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        //focusNode: loginController.emailFocus.value,
        cursorColor: AppColor.primaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          prefixIconColor: AppColor.primaryColor,
          fillColor: AppColor.whiteColor,
          hoverColor: AppColor.whiteColor,
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.primaryColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            Utils.snackBar(title, hint);
            return "Error";
          }
          return null;
        },
        onFieldSubmitted: (value) {}
        /*Utils.fieldFocusChange(
            //context,
            //loginController.emailFocus.value,
            //loginController.passwordFocus.value);
      },*/
        );
  }
}
