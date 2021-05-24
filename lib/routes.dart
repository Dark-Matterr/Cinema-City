import 'package:cinema_city/routes/booking.dart';
import 'package:cinema_city/routes/login.dart';
import 'package:cinema_city/routes/movie.dart';
import 'package:cinema_city/routes/movie_picker.dart';
import 'package:cinema_city/routes/profile.dart';
import 'package:cinema_city/routes/purchase_history.dart';
import 'package:cinema_city/routes/registration.dart';
import 'package:cinema_city/routes/ticket.dart';
import 'package:cinema_city/routes/ticket_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String moviePage = '/user/movieinfo';
  static const String bookPage = '/user/booking';
  static const String ticketSuccessPage = '/user/booking/ticketsuccess';
  static const String historyPage = '/profile/history';
  static const String ticketPage = '/profile/history/ticket';
  static const String profilePage = '/profile';
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
      case ticketSuccessPage:
        return MaterialPageRoute(builder: (_) => TicketSuccesscreen());
      case historyPage:
        return MaterialPageRoute(builder: (_) => PurchaseHistoryScreen());
      case ticketPage:
        return MaterialPageRoute(builder: (_) => TicketScreen());
      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        throw FormatException("Routes Not Found");
    }
  }
}
