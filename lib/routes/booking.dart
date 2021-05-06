import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/booking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingServices(),
      child: BookingScreenChild(),
    );
  }
}

class BookingScreenChild extends StatelessWidget {
  String val;
  List<String> _listitem = ["12/30/21", "12/29/21", "12/20/21"];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _bookingprovider =
        Provider.of<BookingServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
              child: Consumer<BookingServices>(
            builder: (_, cache, __) => Column(
              children: [
                // Date to book dropdown
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff4f4f4f),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.defaultSize * 0.01,
                      horizontal: SizeConfig.defaultSize * 1),
                  child: DropdownButton(
                    hint: Text(
                      "Date to watch",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.defaultSize * 1.8),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    ),
                    iconSize: SizeConfig.defaultSize * 2.9,
                    dropdownColor: Color(0xff4f4f4f),
                    underline: SizedBox(),
                    value: cache.date,
                    style: TextStyle(color: Colors.white),
                    onChanged: (newval) {
                      cache.date = newval;
                      print(cache.date);
                    },
                    items: _listitem.map((itemval) {
                      return new DropdownMenuItem(
                        value: itemval,
                        child: Text(itemval,
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.8,
                            )),
                      );
                    }).toList(),
                  ),
                ),
                // Time toggle Buttons
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                  child: ToggleButtons(
                    fillColor: Colors.orange,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text("9:00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.6)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text("9:00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.6)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text("9:00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.6)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text("9:00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.6)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text("9:00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.defaultSize * 1.6)),
                      ),
                    ],
                    onPressed: (int index) {
                      cache.timeIndex = index;
                    },
                    isSelected: cache.listtime,
                  ),
                ),
                // Seats availability Indicator
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.defaultSize * 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(children: [
                          // Available indicator
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: SizedBox(),
                          ),
                          SizedBox(
                            width: SizeConfig.defaultSize * 1,
                          ),
                          Text(
                            "AVAILABLE",
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.8),
                          ),
                        ]),
                      ),
                      SizedBox(
                        width: SizeConfig.defaultSize * 5,
                      ),
                      // Taken Indicator
                      Container(
                        child: Row(children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.grey,
                            child: SizedBox(),
                          ),
                          SizedBox(
                            width: SizeConfig.defaultSize * 1,
                          ),
                          Text(
                            "TAKEN",
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.8),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                // Seats Picker
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize * 4),
                  margin: EdgeInsets.only(
                      top: SizeConfig.defaultSize * 3,
                      bottom: SizeConfig.defaultSize * 2),
                  child: Column(children: [
                    Wrap(
                      runSpacing: SizeConfig.defaultSize * 1.2,
                      spacing: SizeConfig.defaultSize * 1,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        40,
                        (index) => Container(
                          padding: EdgeInsets.all(SizeConfig.defaultSize * 1.9),
                          color: Colors.grey,
                          child: SizedBox(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 3,
                    ),
                    Row(children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.defaultSize * 2,
                              right: SizeConfig.defaultSize * 2,
                            ),
                            child: Divider(
                              color: Colors.grey,
                            )),
                      ),
                      Text(
                        "SCREEN",
                        style:
                            TextStyle(fontSize: SizeConfig.defaultSize * 1.5),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.defaultSize * 2,
                              right: SizeConfig.defaultSize * 2,
                            ),
                            child: Divider(
                              color: Colors.grey,
                            )),
                      ),
                    ]),
                  ]),
                ),
                // Checkout
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                        child: Text(
                          "TOTAL: 400",
                          style:
                              TextStyle(fontSize: SizeConfig.defaultSize * 2),
                        ),
                      ),
                      Container(
                        color: Colors.teal,
                        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                        child: Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
