import 'dart:convert';

import 'package:cinema_city/models/movieschedule_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingServices with ChangeNotifier {
  final String url = "http://192.168.152.2/cinema/api.php";
  DateTime parseSel;
  String _selDate;
  String _selTime;
  int index = -1;

  //Scheduled Date Movies
  Future<List<Schedule>> movieSchedule(String movieid) async {
    var data = {
      "access": "moviesched",
      "movie_id": movieid,
    };
    var res = await http.post(url, body: data);
    if (res.statusCode == 200) {
      var list = jsonDecode(res.body) as List;
      var sched = list.map((val) => Schedule.fromJson(val)).toList();

      return sched;
    } else {
      throw Exception('Failed to Load the Server');
    }
  }

  // Get all occupied seats
  Future<List<int>> seatsOccupied(
      String movieid, String reserveYear, String reserveHour) async {
    var data = {
      "access": "seatoccupy",
      "movie_id": movieid,
      "reserve_year": reserveYear,
      "reserve_time": reserveHour,
    };
    var res = await http.post(url, body: data);
    if (res.statusCode == 200) {
      var jsonlist = jsonDecode(res.body) as List;
      var seatslist = jsonlist.map((e) => int.parse(e.toString())).toList();
      return seatslist;
    } else {
      throw Exception('Failed to Load the Server');
    }
  }

  Future<List<int>> getOccupiedSeats(String movieid) async {
    return await seatsOccupied(
        movieid, parseSel.year.toString(), parseSel.hour.toString());
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
    parseSel = DateTime.parse(_selDate.toString() + " " + _selTime.toString());
    notifyListeners();
  }
}
