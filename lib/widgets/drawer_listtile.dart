import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function ontap;
  const DrawerListTile(this.icon, this.title, this.ontap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.8),
      leading: Icon(icon, color: Colors.white),
      title: Text(title,
          style: TextStyle(
              color: Colors.white, fontSize: SizeConfig.defaultSize * 1.7)),
      hoverColor: Colors.grey,
      onTap: ontap,
    );
  }
}
