import 'dart:convert';
import 'package:cinema_city/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

class UserServices with ChangeNotifier {
  // Signing in request
  Future<int> login({
    String email,
    String password,
  }) async {
    var data = {
      "user_email": email,
      "user_pass": password,
      "access": "login",
    };
    var res = await http.post(server_url, body: data);

    if (res.statusCode == 200) {
      var status = jsonDecode(res.body);
      if (status == 0) {
        return 0;
      } else {
        final prefs = await SharedPreferences.getInstance();
        List<User> userInfo =
            (status as List).map((val) => User.fromJson(val)).toList();
        await prefs.setInt('user_id', userInfo[0].userId);
        await prefs.setString('user_email', userInfo[0].userEmail);
        await prefs.setString('user_fname', userInfo[0].userFname);
        await prefs.setString('user_lname', userInfo[0].userLname);
        return 1;
      }
    } else {
      throw Exception('Failed to Load the Server');
    }
  }

  // Register request
  Future<int> register({
    String email,
    String fname,
    String lname,
    String password,
  }) async {
    var data = {
      "reg_email": email,
      "reg_fname": fname,
      "reg_lname": lname,
      "reg_pass": password,
      "access": "register",
    };
    var res = await http.post(server_url, body: data);
    if (res.statusCode == 200) {
      notifyListeners();
      return jsonDecode(res.body);
    } else {
      notifyListeners();
      return -1;
    }
  }

  Future<int> userSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<void> userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
    prefs.remove("user_email");
    prefs.remove("user_fname");
    prefs.remove("user_lname");
  }
}
