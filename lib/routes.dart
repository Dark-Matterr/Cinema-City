import 'package:cinema_city/routes/booking.dart';
import 'package:cinema_city/routes/login.dart';
import 'package:cinema_city/routes/movie.dart';
import 'package:cinema_city/routes/movie_picker.dart';
import 'package:cinema_city/routes/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String moviePage = '/movieinfo';
  static const String bookPage = '/booking';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => MoviePickerScreen());
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerPage:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case moviePage:
        return MaterialPageRoute(builder: (_) => MovieScreen());
      case bookPage:
        return MaterialPageRoute(builder: (_) => BookingScreen());
      default:
        throw FormatException("Routes Not Found");
    }
  }
}
