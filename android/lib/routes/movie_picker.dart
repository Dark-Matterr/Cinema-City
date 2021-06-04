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
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                              child: FutureBuilder(
                                  future: SharedPreferences.getInstance(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return (snapshot.data
                                                  .containsKey('user_id') &&
                                              snapshot.data
                                                  .containsKey('user_email') &&
                                              snapshot.data
                                                  .containsKey('user_fname') &&
                                              snapshot.data
                                                  .containsKey('user_lname'))
                                          // if there is a session
                                          ? ListView(
                                              children: <Widget>[
                                                DrawerHeader(
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            colors: <Color>[
                                                          cPrimaryColor,
                                                          Color(0xffff6347),
                                                        ])),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .all(SizeConfig
                                                                            .defaultSize *
                                                                        1),
                                                                child:
                                                                    CircleAvatar(
                                                                  maxRadius:
                                                                      SizeConfig
                                                                              .defaultSize *
                                                                          3,
                                                                  backgroundImage:
                                                                      AssetImage(
                                                                    "assets/icons/user.png",
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "${snapshot.data.getString("user_fname")} ${snapshot.data.getString("user_lname")}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              SizeConfig.defaultSize * 1.7),
                                                                    ),
                                                                    Text(
                                                                      "${snapshot.data.getString("user_email")}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              SizeConfig.defaultSize * 1),
                                                                    ),
                                                                  ]),
                                                            ],
                                                          )
                                                        ])),
                                                DrawerListTile(Icons.history,
                                                    "Purchase History", () {
                                                  Navigator.of(context)
                                                      .pushNamed(RouteGenerator
                                                          .historyPage);
                                                }),
                                                DrawerListTile(Icons.vpn_key,
                                                    "Update Password", () {
                                                  Navigator.of(context)
                                                      .pushNamed(RouteGenerator
                                                          .profilePage);
                                                }),
                                                DrawerListTile(
                                                    Icons.logout, "Logout", () {
                                                  UserServices().userLogout();
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          RouteGenerator
                                                              .homePage,
                                                          (route) => false);
                                                }),
                                              ],
                                            )
                                          : ListView(
                                              children: <Widget>[
                                                DrawerHeader(
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            colors: <Color>[
                                                          cPrimaryColor,
                                                          Color(0xffff6347),
                                                        ])),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .all(SizeConfig
                                                                            .defaultSize *
                                                                        1),
                                                                child:
                                                                    CircleAvatar(
                                                                  maxRadius:
                                                                      SizeConfig
                                                                              .defaultSize *
                                                                          3,
                                                                  backgroundImage:
                                                                      AssetImage(
                                                                    "assets/icons/user.png",
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "Guest",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              SizeConfig.defaultSize * 2.2),
                                                                    ),
                                                                    Text(
                                                                      "Please login to transact",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              SizeConfig.defaultSize * 1.1),
                                                                    ),
                                                                  ]),
                                                            ],
                                                          )
                                                        ])),
                                                DrawerListTile(
                                                    Icons.login, "Login", () {
                                                  Navigator.of(context)
                                                      .pushNamed(RouteGenerator
                                                          .loginPage);
                                                }),
                                                DrawerListTile(
                                                    Icons.app_registration,
                                                    "Register", () {
                                                  Navigator.of(context)
                                                      .pushNamed(RouteGenerator
                                                          .registerPage);
                                                }),
                                              ],
                                            );
                                    }
                                    return CircularProgressIndicator();
                                  }),
                            ),
                            appBar: AppBar(
                              title: TitleWidget(SizeConfig.defaultSize * 0.2),
                              centerTitle: true,
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
                              child: SpinKitCircle(
                        color: cPrimaryColor,
                        size: SizeConfig.defaultSize * 8,
                      )));
                    });
              })
            : NoInternetScreen();
      }
      return Scaffold(
          body: Center(
              child: SpinKitCircle(
        color: cPrimaryColor,
        size: SizeConfig.defaultSize * 8,
      )));
    });
  }
}
