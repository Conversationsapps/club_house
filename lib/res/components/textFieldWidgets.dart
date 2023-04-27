import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/app_color.dart';


class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;
  const TextFieldWidget({Key? key, required this.label, required this.text, required this.onChanged,  this.maxLines = 1}) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
   controller = TextEditingController(text: widget.text);
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: TextStyle(fontSize: 16, color: AppColor.blackColor),),
          SizedBox(height: 8,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
            ),
            maxLines: widget.maxLines,
            controller: controller,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
