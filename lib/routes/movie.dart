import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/movie.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/movie_about_row.dart';
import 'package:cinema_city/widgets/movie_genre_listtile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<MovieServices>(
      builder: (_, cache, __) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.defaultSize * 25,
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.darken),
                          image: NetworkImage(cache.movie[cache.index].image),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  color: Color(0xff1a1a1a),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 1.2,
                    vertical: SizeConfig.defaultSize * 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Title
                      Container(
                        child: Text(
                          cache.movie[cache.index].title,
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "PHP ${cache.movie[cache.index].price}".toString(),
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 2.5,
                            color: cSecondaryColor,
                          ),
                        ),
                      ),
                      // Movie Genre
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.defaultSize * 1.5,
                            bottom: SizeConfig.defaultSize * 2),
                        child: Row(
                            children: List.generate(
                                cache.genres[cache.index].length,
                                (index) => GenreListTile(
                                    cache.genres[cache.index][index]))),
                      ),
                      // Sypnosis title
                      Text(
                        "Sypnosis\n",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.8,
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MovieAboutList(
                              "Director", cache.movie[cache.index].director),
                          MovieAboutList("Cast", cache.movie[cache.index].cast),
                          MovieAboutList("Date Released",
                              "${DateFormat.yMMMMd().format(cache.movie[cache.index].release).toString()}"),
                        ],
                      )
                    ],
                  ),
                ),
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
              Navigator.pushNamed(context, RouteGenerator.bookPage);
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
