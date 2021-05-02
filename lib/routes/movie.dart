import 'package:cinema_city/constant.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/movie_about_row.dart';
import 'package:cinema_city/widgets/movie_genre_listtile.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close),
      ),
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
                        image: AssetImage("assets/your_name.jpg"),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Your Name",
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          // Genre
                          Container(
                            child: Row(
                              children: [
                                GenreListTile("Romance"),
                                GenreListTile("Fantasy"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        "Mitsuha is the daughter of the mayor of a small mountain town. She's a straightforward high school girl who lives with her sister and her grandmother and has no qualms about letting it be known that she's uninterested in Shinto rituals or helping her father's electoral campaign. Instead she dreams of leaving the boring town and trying her luck in Tokyo. Taki is a high school boy in Tokyo who works part-time in an Italian restaurant and aspires to become an architect or an artist. Every night he has a strange dream where he becomes...a high school girl in a small mountain town. ",
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
                        MovieAboutList("Director", "Makoto Shinkai"),
                        MovieAboutList(
                            "Cast", "Ryunosuke Kamiki, Mone Kamishiraishi"),
                        MovieAboutList("Date Released", "7 April 2017"),
                        MovieAboutList("Ticket Price", "P200"),
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
        child: RaisedButton(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 0.6),
          color: cPrimaryColor,
          onPressed: () {},
          child: Text(
            "Buy Ticket",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.defaultSize * 2),
          ),
        ),
      ),
    );
  }
}
