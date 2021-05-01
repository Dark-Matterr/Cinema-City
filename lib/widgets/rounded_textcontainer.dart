import 'package:cinema_city/constant.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final Widget child;
  const TextContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Color(0xffefefd2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
