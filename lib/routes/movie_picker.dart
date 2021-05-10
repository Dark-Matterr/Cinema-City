import 'package:cinema_city/provider/movie.dart';
import 'package:cinema_city/provider/user.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/drawer_listtile.dart';
import 'package:cinema_city/widgets/movie_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviePickerScreen extends StatelessWidget {
  MoviePickerScreen();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MoviePickerChild();
  }
}

class MoviePickerChild extends StatelessWidget {
  const MoviePickerChild();
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieServices>(builder: (context, cache, _) {
      return FutureBuilder(
          future: cache.getMovie(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cache.movie = snapshot.data;
              return Scaffold(
                extendBodyBehindAppBar: true,
                drawer: Drawer(
                  elevation: 1,
                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[
                                Color(0xffec7532),
                                Color(0xfffbbd61),
                              ])),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.all(SizeConfig.defaultSize * 1),
                                child: CircleAvatar(
                                  maxRadius: SizeConfig.defaultSize * 3.5,
                                  backgroundImage: AssetImage(
                                    "assets/icons/user.png",
                                  ),
                                ),
                              ),
                              Text(
                                "Dominic Antigua",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.defaultSize * 1.5),
                              )
                            ],
                          )),
                      DrawerListTile(Icons.person, "Profile", () {}),
                      DrawerListTile(
                          Icons.clean_hands, "Purchase History", () {}),
                      DrawerListTile(Icons.logout, "Logout", () {
                        UserServices().userLogout();
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteGenerator.loginPage, (route) => false);
                      }),
                    ],
                  ),
                ),
                appBar: AppBar(
                  actions: [Icon(Icons.search)],
                ),
                body: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.defaultSize * 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => MovieListTile(
                              title: snapshot.data[index].title,
                              image: snapshot.data[index].image,
                              onPress: () {
                                cache.index = index;
                                Navigator.of(context)
                                    ?.pushNamed(RouteGenerator.moviePage);
                              }),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
                body: Center(child: Image.asset("assets/icons/ripple.gif")));
          });
    });
  }
}
