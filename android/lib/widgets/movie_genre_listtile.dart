import 'package:flutter/material.dart';

import '../constant.dart';
import '../size_config.dart';

class GenreListTile extends StatelessWidget {
  final String genretxt;
  const GenreListTile(this.genretxt);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: SizeConfig.defaultSize * 0.7),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cPrimaryColor,
      ),
      child: Text(
        genretxt,
        style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3),
      ),
    );
  }
}
