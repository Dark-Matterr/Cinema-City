import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/connectivity.dart';
import 'package:cinema_city/provider/movie.dart';
import 'package:cinema_city/provider/user.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/routes/no_internet.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/drawer_listtile.dart';
import 'package:cinema_city/widgets/movie_listtile.dart';
import 'package:cinema_city/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviePickerScreen extends StatefulWidget {
  MoviePickerScreen();

  @override
  _MoviePickerScreenState createState() => _MoviePickerScreenState();
}

class _MoviePickerScreenState extends State<MoviePickerScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityServices>(context, listen: false).startMonitoring();
  }

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
    return Consumer<ConnectivityServices>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
            ? Consumer<MovieServices>(builder: (context, cache, _) {
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
                                      child: Column(children: [
                                    Container(
                                        alignment: Alignment.center,
                                        width: SizeConfig.screenWidth,
                                        margin: EdgeInsets.only(
                                          bottom: SizeConfig.defaultSize * 0.5,
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey))),
                                        padding: EdgeInsets.only(
                                            bottom:
                                                SizeConfig.defaultSize * 0.8),
                                        child: TitleWidget(
                                            SizeConfig.defaultSize * 0.15)),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              SizeConfig.defaultSize * 1),
                                          child: CircleAvatar(
                                            maxRadius:
                                                SizeConfig.defaultSize * 3,
                                            backgroundImage: AssetImage(
                                              "assets/icons/user.png",
                                            ),
                                          ),
                                        ),
                                        FutureBuilder(
                                            future:
                                                SharedPreferences.getInstance(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${snapshot.data.getString("user_fname")} ${snapshot.data.getString("user_lname")}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: SizeConfig
                                                                    .defaultSize *
                                                                1.7),
                                                      ),
                                                      Text(
                                                        "${snapshot.data.getString("user_email")}",
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .defaultSize *
                                                                1),
                                                      ),
                                                    ]);
                                              }
                                              return CircularProgressIndicator();
                                            })
                                      ],
                                    )
                                  ])),
                                  DrawerListTile(
                                      Icons.history, "Purchase History", () {
                                    Navigator.of(context)
                                        .pushNamed(RouteGenerator.historyPage);
                                  }),
                                  DrawerListTile(
                                      Icons.vpn_key, "Update Password", () {
                                    Navigator.of(context)
                                        .pushNamed(RouteGenerator.profilePage);
                                  }),
                                  DrawerListTile(Icons.logout, "Logout", () {
                                    UserServices().userLogout();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouteGenerator.loginPage,
                                        (route) => false);
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
                                      itemBuilder: (context, index) =>
                                          MovieListTile(
                                              title: cache.movie[index].title,
                                              image:
                                                  "$server_url${cache.movie[index].image}",
                                              onPress: () {
                                                cache.index = index;
                                                Navigator.of(context)
                                                    ?.pushNamed(RouteGenerator
                                                        .moviePage);
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
                          body: Center(
                              child: Image.asset("assets/icons/ripple.gif")));
                    });
              })
            : NoInternetScreen();
      }
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
