import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserServices with ChangeNotifier {
  final String _url = "http://192.168.152.2/cinema/access.php";

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
    var res = await http.post(_url, body: data);

    if (res.statusCode == 200) {
      var status = jsonDecode(res.body);
      if (status >= 1) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', status);
        return 1;
      } else {
        return 0;
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
    var res = await http.post(_url, body: data);
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
  }
}
