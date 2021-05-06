import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/movie.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/movie_about_row.dart';
import 'package:cinema_city/widgets/movie_genre_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<MovieServices>(
      builder: (_, cache, __) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.defaultSize * 30,
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: 'zn2GwbPG-tc', //Add videoID.
                      flags: YoutubePlayerFlags(
                        hideControls: false,
                        controlsVisibleAtStart: true,
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                ),
                //Sypnosis
                Container(
                  color: Color(0xff1a1a1a),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 1.2,
                    vertical: SizeConfig.defaultSize * 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sypnosis title
                      Text(
                        "Sypnosis\n",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.8,
                          color: cSecondaryColor,
                        ),
                      ),
                      // Sypnosis description
                      Container(
                        child: Text(
                          cache.movie[cache.index].description,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConfig.defaultSize * 1.4),
                        ),
                      )
                    ],
                  ),
                ),
                // About
                Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(
                    left: SizeConfig.defaultSize * 1.2,
                    right: SizeConfig.defaultSize * 1.2,
                    top: SizeConfig.defaultSize * 1.2,
                    bottom: SizeConfig.defaultSize * 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About\n",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.8,
                          color: cSecondaryColor,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MovieAboutList(
                              "Director", cache.movie[cache.index].director),
                          MovieAboutList(
                              "Cast", "Ryunosuke Kamiki, Mone Kamishiraishi"),
                          MovieAboutList("Date Released",
                              cache.movie[cache.index].release),
                          MovieAboutList("Ticket Price",
                              "P${cache.movie[cache.index].price}".toString()),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: 1,
          child: MaterialButton(
            padding: EdgeInsets.all(SizeConfig.defaultSize * 0.6),
            color: cPrimaryColor,
            onPressed: () {
              print(cache.index);
            },
            child: Text(
              "Buy Ticket",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.defaultSize * 2),
            ),
          ),
        ),
      ),
    );
  }
}
