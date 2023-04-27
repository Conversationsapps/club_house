import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(context, "5.8", "Ranking"),
          buildDivider(),
          buildButton(context, "25", "Following"),
          buildDivider(),
          buildButton(context, "50", "Followers"),

        ],
      ),
    );
  }
  Widget buildDivider(){
    return Container(
      height: 25,
        child: VerticalDivider(thickness: 2.0,));
  }
 Widget buildButton(BuildContext context, String value, String text){
    return MaterialButton(
      padding:  EdgeInsets.symmetric(vertical: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {  },
      child: Column(
        mainAxisSize: MainAxisSize.min,
       mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(value,),
          SizedBox(height: 2,),
          Text(text,)
      ],

      ),
    );

  }
}
