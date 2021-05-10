import 'dart:convert';

import 'package:cinema_city/models/movieschedule_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingServices with ChangeNotifier {
  final String _url = "http://192.168.152.2/cinema/api.php";
  DateTime parseSel;
  String _selDate;
  String _selTime;
  int index = -1;
  List<bool> _seatsToggle = List.generate(40, (index) => false);

  BookingServices();

  //Scheduled Date Movies
  Future<List<Schedule>> movieSchedule(String movieid) async {
    var data = {
      "access": "moviesched",
      "movie_id": movieid,
    };
    var res = await http.post(_url, body: data);
    if (res.statusCode == 200) {
      var list = jsonDecode(res.body) as List;
      var sched = list.map((val) => Schedule.fromJson(val)).toList();

      return sched;
    } else {
      throw Exception('Failed to Load the Server');
    }
  }

  // Get all occupied seats
  Future<List<int>> seatsOccupied(String movieid, String reserveYear,
      String reserveHour, String reserveDay) async {
    var data = {
      "access": "seatoccupy",
      "movie_id": movieid,
      "reserve_year": reserveYear,
      "reserve_time": reserveHour,
      "reserve_day": reserveDay,
    };
    var res = await http.post(_url, body: data);
    if (res.statusCode == 200) {
      var jsonlist = jsonDecode(res.body) as List;
      List<String> intlist = jsonlist.map((e) => e.toString()).toList();
      List<int> seatslist = [];
      intlist.map((e) {
        List<String> splet = e.split(",");
        for (int i = 0; i < splet.length; i++) {
          seatslist.add(int.parse(splet[i]));
        }
      }).toList();
      return seatslist;
    } else {
      throw Exception('Failed to Load the Server');
    }
  }

  Future<List<int>> getOccupiedSeats(String movieid) async {
    return await seatsOccupied(movieid, parseSel.year.toString(),
        parseSel.hour.toString(), parseSel.day.toString());
  }

  // Distict Date
  List<String> distinctDate(List<Schedule> list) {
    List<String> distinctlist = [];
    for (int i = 0; i < list.length; i++) {
      if (!distinctlist.contains(list[i].date)) {
        distinctlist.add(list[i].date);
      }
    }
    return distinctlist;
  }

  // Distinct Time
  List<String> distinctTime(String date, List<Schedule> list) {
    List<String> distinctlist = [];
    for (int i = 0; i < list.length; i++) {
      if (!distinctlist.contains(list[i].timestart) && date == list[i].date) {
        distinctlist.add(list[i].timestart);
      }
    }
    return distinctlist;
  }

  // Toggle Labels
  List<String> toggleLabels(List<Schedule> list) {
    return distinctTime(selDate, list)
        .map((e) => DateFormat.jm()
            .format(DateTime.parse(selDate + " " + e))
            .toString())
        .toList();
  }

  // Seat Picker reset
  void totalSeatReset() {
    _seatsToggle = List.generate(40, (index) => false);
    notifyListeners();
  }

  // Dropdown's Getter and setter data
  String get selDate => _selDate;
  set selDate(String date) {
    _selDate = date;
    notifyListeners();
  }

  // Toggle's Getter and setter data
  String get selTime => _selTime;
  set selTime(String time) {
    _selTime = time;
    parseSel =
        DateTime.tryParse(_selDate.toString() + " " + _selTime.toString());
    notifyListeners();
  }

  //Customer seat toggle picker
  List<bool> get seatsToggle => _seatsToggle;
  set pickSeats(int num) {
    if (_seatsToggle[num] == true) {
      _seatsToggle[num] = false;
    } else {
      _seatsToggle[num] = true;
    }
    notifyListeners();
  }

  // Total amount calculator
  double totalPrice(double moviePrice) {
    double totalPrice = 0.0;
    for (int i = 0; i < _seatsToggle.length; i++) {
      if (_seatsToggle[i]) {
        totalPrice += moviePrice;
      }
    }
    return totalPrice;
  }

  // Get selected Seats of the User
  List<int> selectedSeats() {
    List<int> selection = [];
    for (int i = 0; i < _seatsToggle.length; i++) {
      if (_seatsToggle[i]) {
        selection.add(i);
      }
    }
    return selection;
  }

  Future<int> bookSeatNow(
    int movieId,
    String movieTitle,
    double moviePrice,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id');
    String userName =
        "${prefs.getString('user_fname')} ${prefs.getString('user_lname')}";

    String schedId = (parseSel != null)
        ? "$movieId${parseSel.hour}${parseSel.year}${parseSel.day}"
        : null;
    String ticketId = "$userId$schedId";
    String seatNum = selectedSeats().join(",");

    if (seatNum.isNotEmpty && selTime.isNotEmpty && schedId != null) {
      var data = {
        "ticket_id": ticketId,
        "customer_id": userId.toString(),
        "customer_name": userName,
        "movie_id": movieId.toString(),
        "movie_title": movieTitle,
        "sched_id": schedId,
        "seat_num": seatNum,
        "sched_timestart": selTime,
        "price": totalPrice(moviePrice).toString(),
        "access": "reservation",
      };
      var res = await http.post(_url, body: data);
      if (res.statusCode == 200) {
        return 1;
      } else {
        throw Exception('Failed to Load the Server');
      }
    } else {
      return 0;
    }
  }
}
