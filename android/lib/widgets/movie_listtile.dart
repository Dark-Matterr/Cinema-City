import 'dart:ui';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class MovieListTile extends StatelessWidget {
  final int index;
  final String title;
  final String image;
  final Function onPress;
  const MovieListTile({
    this.index,
    this.title,
    this.image,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 22,
        child: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
              image: NetworkImage(image),
            ),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 3.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
