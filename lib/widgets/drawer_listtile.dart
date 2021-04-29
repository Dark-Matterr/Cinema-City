import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  IconData icon;
  String title;
  Function ontap;
  DrawerListTile(this.icon, this.title, this.ontap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[800]))),
        child: InkWell(
          onTap: ontap,
          child: Container(
            height: SizeConfig.defaultSize * 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style:
                            TextStyle(fontSize: SizeConfig.defaultSize * 1.7),
                      ),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
