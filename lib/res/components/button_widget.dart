import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors/app_color.dart';


class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  const ButtonWidget({Key? key, required this.text, required this.onClicked, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(color),
          shape: MaterialStatePropertyAll(StadiumBorder()),
          overlayColor:  MaterialStatePropertyAll(AppColor.whiteColor),
          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
        ),
          onPressed: ()=> onClicked(),
          child: Text(text,)),
    );
  }
}
