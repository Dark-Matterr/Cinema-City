import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingServices with ChangeNotifier {
  List<bool> _listtime = [true, false, false, false, false];
  String _date;

  //Booking Dates
  String get date => _date;
  set date(String val) {
    _date = val;
    print(_date);
    notifyListeners();
  }

  //Getter Booking Time
  List<bool> get listtime => _listtime;
  // Setter Booking Time Index
  set timeIndex(int index) {
    for (int i = 0; i < _listtime.length; i++) {
      if (index == i) {
        _listtime[i] = true;
      } else {
        _listtime[i] = false;
      }
      notifyListeners();
    }
  }
}
