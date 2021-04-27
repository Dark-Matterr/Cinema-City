import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class LoginModel with ChangeNotifier {
  String _resp = "False";

  Future<void> userSignIn() async {
    var url = "http://192.168.152.2/cinema/login.php";
    var data = {
      "user_email": "antigua.dominic@adamson.edu.ph",
      "user_pass": "dominicpogi"
    };
    var res = await post(url, body: data);
    _resp = res.body;
    notifyListeners();
  }

  String get getresp => _resp;
}
