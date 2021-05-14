import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class MovieAboutList extends StatelessWidget {
  final String about;
  final String parameter;
  const MovieAboutList(this.about, this.parameter);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: SizeConfig.defaultSize * 0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$about: ",
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 1.7,
              color: Color(0xffa5a5a5),
            ),
          ),
          Container(
            width: SizeConfig.defaultSize * 20,
            child: Text(
              parameter,
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.5,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
