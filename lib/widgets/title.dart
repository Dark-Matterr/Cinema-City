import 'package:cinema_city/constant.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final double titleSize;
  const TitleWidget(this.titleSize);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      "Cinema City",
      style: TextStyle(
          fontSize: SizeConfig.defaultSize * titleSize,
          fontWeight: FontWeight.bold,
          color: cPrimaryColor),
    );
  }
}
