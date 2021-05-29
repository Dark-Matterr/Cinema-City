import 'dart:convert';

import 'package:cinema_city/models/purchase.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class TicketServices {
  List<int> _selSeats;
  List<String> _movieGenre;
  String _movieTitle;
  String _runtime;
  String _ticketId;
  String movieImage;
  String username = "";
  int index = -1;

  // Setter and getter of selected seats
  List<int> get selSeats => _selSeats;
  set selSeats(List<int> seats) {
    if (seats.length > 0) {
      _selSeats = seats;
    } else {
      _selSeats = [];
    }
  }

  // Setter and getter of movie genre
  List<String> get movieGenre => _movieGenre;
  set movieGenre(List<String> genres) {
    if (genres.length > 0) {
      _movieGenre = genres;
    } else {
      _movieGenre = [];
    }
  }

  // Setter and getter of movie title
  String get movieTitle => _movieTitle;
  set movieTitle(String title) {
    if (title.isNotEmpty) _movieTitle = title;
  }

  // Setter and getter of runtime
  String get runtime => _runtime;
  set runtime(String time) {
    if (time.isNotEmpty) _runtime = time;
  }

  // Setter and getter of ticket ID
  String get ticketId => _ticketId;
  set ticketId(String ticketid) {
    if (ticketid.isNotEmpty) _ticketId = ticketid;
  }

  //Fetch data from the server
  Future<List<Purchase>> getPurchaseHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getInt("user_id").toString();
    var data = {
      "access": "history",
      "user_id": userId,
    };
    var res = await http.post(server_api, body: data);

    if (res.statusCode == 200) {
      var jsonList = jsonDecode(res.body) as List;
      List<Purchase> purchaseList =
          jsonList.map((e) => Purchase.fromJson(e)).toList();
      return purchaseList;
    } else {
      throw Exception('Failed to Load the Server');
    }
  }
}
