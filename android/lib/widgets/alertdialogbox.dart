import 'package:cinema_city/constant.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String body;
  final String actionText;
  final Function onPress;
  const CustomAlertDialog({
    this.title,
    this.body,
    this.actionText,
    this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: cSecondaryColor,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(body),
      actions: [
        MaterialButton(
          textColor: Colors.white,
          onPressed: onPress,
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
