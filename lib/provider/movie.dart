import 'dart:convert';
import 'dart:core';
import 'package:cinema_city/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  int _index = -1;
  List<Movie> _movies;
  MovieServices();
  Future<List<Movie>> getMovie() async {
    final String _url = "http://192.168.152.2/cinema/access.php";
    var res = await http.post(_url,
        body: {"access": "movies"}, headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      var moviesjson = jsonDecode(res.body) as List;
      final List<Movie> movies =
          (moviesjson).map((val) => Movie.fromJson(val)).toList();
      await Future.delayed(const Duration(seconds: 1));
      return movies;
    } else {
      throw Exception('Failed to Load the Server');
    }
  }

  List<Movie> get movie => _movies;
  set movie(List<Movie> list) {
    if (list.length != 0) {
      _movies = list;
    }
  }

  List<List> get genres => (_movies).map((e) => e.genre.split(",")).toList();

  int get index => _index;
  set index(int value) {
    if ((value >= 0)) {
      _index = value;
    } else {
      _index = -1;
    }
  }
}
