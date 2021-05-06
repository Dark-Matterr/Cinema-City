import 'package:flutter/material.dart';

import '../size_config.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPress;
  const RectangleButton({this.text, this.color, this.onPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenHeight,
      margin: EdgeInsets.only(top: SizeConfig.defaultSize),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 0.8),
        textColor: Colors.white,
        child:
            Text(text, style: TextStyle(fontSize: SizeConfig.defaultSize * 2)),
        color: color,
        onPressed: onPress,
      ),
    );
  }
}
