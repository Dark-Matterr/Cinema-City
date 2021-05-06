import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/movie.dart';
import 'package:cinema_city/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  int session = prefs.getInt('user_id');
  runApp(MyApp(session));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final int session;
  const MyApp(this.session);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<MovieServices>(
            create: (context) => MovieServices(),
          )
        ],
        child: MaterialApp(
          initialRoute: (session == null)
              ? RouteGenerator.loginPage
              : RouteGenerator.homePage,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Cinema City',
          theme: ThemeData(
            canvasColor: cBgColor,
            appBarTheme: AppBarTheme(
              elevation: 0,
              color: Color(0x44000000),
            ),
            scaffoldBackgroundColor: cBgColor,
            textTheme: GoogleFonts.dmSansTextTheme().apply(
              displayColor: Colors.white,
              bodyColor: Colors.white,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ));
  }
}
