import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class LoginModel with ChangeNotifier {
  String _resp = "False";

  Future<void> userSignIn(String email, String password) async {
    var url = "http://192.168.152.2/cinema/login.php";

    var data = {
      "user_email": email,
      "user_pass": password,
    };
    try {
      var res = await post(url, body: data);
      _resp = res.body;
      notifyListeners();
    } catch (e) {
      debugPrint("Can't Connect to Server");
    }
  }

  String get getresp => _resp;
}
