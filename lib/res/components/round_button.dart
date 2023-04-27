import 'package:flutter/material.dart';
import 'package:club_house/res/colors/app_color.dart';
import 'package:club_house/res/dimensions.dart';

class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPress;
  final double height, width;

  const RoundButton({
    Key? key,
    this.loading = false,
    required this.title,
    this.textColor = AppColor.whiteColor,
    this.backgroundColor = AppColor.primaryColor,
    required this.onPress,
    this.height = 50,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: loading ? const Center(child: SizedBox(child: CircularProgressIndicator(color: AppColor.whiteColor,))) : Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
