import 'package:cinema_city/constant.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: cSecondaryColor,
      title: Text(
        "Incorrect email/password",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
          "The email or password didn't match on our records. Please check your inputs."),
      actions: [
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Try Again"),
        ),
      ],
    );
  }
}
