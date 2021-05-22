import 'package:cinema_city/provider/movie.dart';
import 'package:cinema_city/provider/user.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/drawer_listtile.dart';
import 'package:cinema_city/widgets/movie_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              return RefreshIndicator(
                onRefresh: cache.refreshMovie,
                child: Scaffold(
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
                                  padding: EdgeInsets.all(
                                      SizeConfig.defaultSize * 1),
                                  child: CircleAvatar(
                                    maxRadius: SizeConfig.defaultSize * 3.5,
                                    backgroundImage: AssetImage(
                                      "assets/icons/user.png",
                                    ),
                                  ),
                                ),
                                FutureBuilder(
                                  future: SharedPreferences.getInstance(),
                                  builder: (context, snapshot) => Text(
                                    "${snapshot.data.getString("user_fname")} ${snapshot.data.getString("user_lname")}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.defaultSize * 1.5),
                                  ),
                                )
                              ],
                            )),
                        DrawerListTile(Icons.person, "Profile", () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.profilePage);
                        }),
                        DrawerListTile(Icons.clean_hands, "Purchase History",
                            () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.historyPage);
                        }),
                        DrawerListTile(Icons.logout, "Logout", () {
                          UserServices().userLogout();
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteGenerator.loginPage, (route) => false);
                        }),
                      ],
                    ),
                  ),
                  appBar: AppBar(),
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
                            itemCount: cache.movie.length,
                            itemBuilder: (context, index) => MovieListTile(
                                title: cache.movie[index].title,
                                image: cache.movie[index].image,
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
                ),
              );
            }
            return Scaffold(
                body: Center(child: Image.asset("assets/icons/ripple.gif")));
          });
    });
  }
}
