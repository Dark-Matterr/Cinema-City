import 'package:cinema_city/routes/booking.dart';
import 'package:cinema_city/routes/login.dart';
import 'package:cinema_city/routes/movie.dart';
import 'package:cinema_city/routes/movie_picker.dart';
import 'package:cinema_city/routes/purchase_history.dart';
import 'package:cinema_city/routes/registration.dart';
import 'package:cinema_city/routes/ticket_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String moviePage = '/movieinfo';
  static const String bookPage = '/booking';
  static const String ticketPage = '/ticket';
  static const String historyPage = '/history';

  const RouteGenerator._();

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
      case ticketPage:
        return MaterialPageRoute(builder: (_) => TicketScreen());
      case historyPage:
        return MaterialPageRoute(builder: (_) => PurchaseHistoryScreen());
      default:
        throw FormatException("Routes Not Found");
    }
  }
}
