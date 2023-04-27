import 'dart:io';
import 'package:club_house/res/dimensions.dart';
import 'package:flutter/material.dart';

import '../colors/app_color.dart';

class ProfileWidgets extends StatefulWidget {
  final bool isEdit;
  final String imagePath;
  final VoidCallback onClicked;
  const ProfileWidgets({Key? key, required this.imagePath, required this.onClicked, required this.isEdit}) : super(key: key);

  @override
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
          children: [
            buildImage(context),
            Positioned(
              bottom: 0,
                right: 4,
                child: buildEditButton(color))
          ]),
    );
  }

  Widget buildImage(BuildContext context){
    final image = widget.imagePath.contains('https://')? NetworkImage(widget.imagePath): FileImage(File(widget.imagePath));
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
            image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: (){
            widget.onClicked();
          },),
        ),
      ),
    );
  }

  buildEditButton(Color color){
    return buildCircle(
        child: buildCircle(
            child: widget.isEdit == false? Icon(Icons.edit, color: AppColor.whiteColor,size: 20,):Icon(Icons.camera_alt, color: AppColor.whiteColor,size: 15,),
            color: AppColor.primaryColor,
            all: 10),
            color: AppColor.whiteColor,
            all: 3);


  }

  buildCircle({required Widget child, required Color color, required double all}){
    return ClipOval(
      child: Container(
        child: child,
        color: color,
        padding: EdgeInsets.all(all),
      ),
    );

  }
}
