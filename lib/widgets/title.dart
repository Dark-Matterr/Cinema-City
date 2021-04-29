import 'package:cinema_city/constant.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  double titleSize = 0;
  TitleWidget(this.titleSize);
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
