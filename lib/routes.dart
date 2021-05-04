import 'package:cinema_city/routes/login.dart';
import 'package:cinema_city/routes/movie_picker.dart';
import 'package:cinema_city/routes/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String loginPage = '/login';
  static const String registerPage = '/register';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => MoviePickerScreen());
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerPage:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      default:
        throw FormatException("Routes Not Found");
    }
  }
}
