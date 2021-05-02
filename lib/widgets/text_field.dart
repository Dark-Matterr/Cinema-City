import 'package:flutter/material.dart';

import '../size_config.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController control;
  final String text;
  final Color color;
  final IconData icon;
  final bool secured;
  CustomTextField(
      {this.text, this.color, this.icon, this.secured, this.control});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01),
      child: TextFormField(
        controller: control,
        obscureText: secured,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc1071e))),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          prefixIcon: (icon != null)
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : null,
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
