import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/drawer_listtile.dart';
import 'package:cinema_city/widgets/movie_listtile.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                      padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
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
            DrawerListTile(Icons.clean_hands, "Agreement", () {}),
            DrawerListTile(Icons.logout, "Logout", () {}),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        centerTitle: true,
        actions: [Icon(Icons.search)],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child: Expanded(
                    child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => MovieListTile(),
            ))),
          ],
        ),
      ),
    );
  }
}