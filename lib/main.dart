import 'package:cinema_city/constant.dart';
import 'package:cinema_city/screens/login.dart';
import 'package:cinema_city/screens/movie.dart';
import 'package:cinema_city/screens/movie_picker.dart';
import 'package:cinema_city/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: RegistrationScreen(),
    );
  }
}
