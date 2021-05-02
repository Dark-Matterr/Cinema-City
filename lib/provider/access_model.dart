import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class AccessModel with ChangeNotifier {
  int _resp = 0;
  Future<void> login({
    String email,
    String password,
  }) async {
    var url = "http://192.168.152.2/cinema/login.php";

    var data = {
      "user_email": email,
      "user_pass": password,
    };
    var res = await post(url, body: data);

    if (res.statusCode == 200) {
      notifyListeners();
      _resp = jsonDecode(res.body);
    } else {
      notifyListeners();
      _resp = -1;
    }
  }

  // Getter
  int get getResp => _resp;
}
