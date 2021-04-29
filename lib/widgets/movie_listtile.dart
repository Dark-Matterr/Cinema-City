import 'dart:ui';

import 'package:cinema_city/constant.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieListTile extends StatelessWidget {
  final int index;
  const MovieListTile({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 22,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
              image: AssetImage("assets/sample_movie.jpg"),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    "Starboy",
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: 2,
                      size: SizeConfig.defaultSize * 3,
                      isReadOnly: true,
                      color: cSecondaryColor,
                      borderColor: cSecondaryColor,
                      spacing: 0.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Text(
                        "Price: 100.0",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
