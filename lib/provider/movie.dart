import 'dart:convert';
import 'dart:core';
import 'package:cinema_city/models/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class MovieServices with ChangeNotifier {
  int _index = -1;
  List<Movie> _movies;
  MovieServices();

  Future<List<Movie>> getMovie() async {
    var res = await http.post(server_url,
        body: {"access": "movies"}, headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      var moviesjson = jsonDecode(res.body) as List;
      final List<Movie> movies =
          (moviesjson).map((val) => Movie.fromJson(val)).toList();
      await Future.delayed(const Duration(seconds: 1));
      _movies = movies;
      return movies;
    } else {
      throw Exception('Failed to Load the Server');
    }
  }

  Future<Null> refreshMovie() async {
    _movies = await getMovie();
    notifyListeners();
  }

  List<Movie> get movie => _movies;
  set movie(List<Movie> list) {
    if (list.length != 0) {
      _movies = list;
    }
  }

  // get the specific genres of a movie
  List<List> get genres => (_movies).map((e) => e.genre.split(",")).toList();

  // Routing index cache index
  int get index => _index;
  set index(int value) {
    if ((value >= 0)) {
      _index = value;
    } else {
      _index = -1;
    }
  }
}
