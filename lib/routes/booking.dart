import 'package:cinema_city/provider/booking.dart';
import 'package:cinema_city/provider/movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constant.dart';
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int toggleIndex = 0;
    final _bookingServices =
        Provider.of<BookingServices>(context, listen: false);
    // Get the index movie cache in Movie Services
    return Consumer<MovieServices>(
      builder: (_, movieCache, __) => FutureBuilder(
          future: _bookingServices
              .movieSchedule(movieCache.movie[movieCache.index].id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      child: Column(
                        children: [
                          // DropDown Date
                          Padding(
                            padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Consumer<BookingServices>(
                                builder: (_, cache, __) => DropdownButton(
                                  hint: Text(
                                    "Select Reservation Date",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  iconSize: 30,
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  dropdownColor: Color(0xff4f4f4f),
                                  // Value setter
                                  value: _bookingServices.selDate,
                                  // Drop Down value onchange
                                  onChanged: (newVal) {
                                    _bookingServices.selDate = newVal;
                                  },
                                  items: cache
                                      .distinctDate(snapshot.data)
                                      .map((valueItem) => DropdownMenuItem(
                                            value: valueItem,
                                            child: Text(valueItem),
                                          ))
                                      .toList(),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff4f4f4f),
                              ),
                            ),
                          ),
                          // End DropDown Date
                          // Time Selector
                          Consumer<BookingServices>(
                              builder: (_, cache, __) => (_bookingServices
                                          .distinctTime(
                                              _bookingServices.selDate,
                                              snapshot.data)
                                          .length !=
                                      0)
                                  ? Container(
                                      child: ToggleSwitch(
                                          initialLabelIndex: cache.index,
                                          minWidth: SizeConfig.defaultSize * 10,
                                          minHeight: SizeConfig.defaultSize * 5,
                                          activeBgColor: cButtonColor,
                                          labels:
                                              (_bookingServices.distinctTime(
                                                  _bookingServices.selDate,
                                                  snapshot.data)),
                                          onToggle: (index) {
                                            // Set selected date in Booking Service
                                            _bookingServices.selTime =
                                                _bookingServices.distinctTime(
                                                    _bookingServices.selDate,
                                                    snapshot.data)[index];
                                            cache.index = index;
                                          }),
                                    )
                                  : Container(
                                      child: ToggleSwitch(
                                        initialLabelIndex: 0,
                                        minWidth: SizeConfig.defaultSize * 15,
                                        minHeight: SizeConfig.defaultSize * 5,
                                        activeBgColor: cButtonColor,
                                        labels: ["No Time Slot"],
                                      ),
                                    )),
                          // End of Time Selector
                          // Seat Indicator
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.defaultSize * 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(children: [
                                    // Available indicator
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      color: Color(0xff52505B),
                                      child: SizedBox(),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.defaultSize * 1,
                                    ),
                                    Text(
                                      "AVAILABLE",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.defaultSize * 1.8),
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
                                      color: Colors.black,
                                      child: SizedBox(),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.defaultSize * 1,
                                    ),
                                    Text(
                                      "TAKEN",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.defaultSize * 1.8),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          // End of Seat Indicator
                          // Seat Picker
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.defaultSize * 4),
                            margin: EdgeInsets.only(
                                top: SizeConfig.defaultSize * 3,
                                bottom: SizeConfig.defaultSize * 2),
                            child: Column(children: [
                              Consumer<BookingServices>(
                                  builder: (_, cache, __) {
                                return Wrap(
                                    runSpacing: SizeConfig.defaultSize * 1.2,
                                    spacing: SizeConfig.defaultSize * 1,
                                    alignment: WrapAlignment.center,
                                    children: List.generate(
                                        40,
                                        (index) =>
                                            (index == cache.parseSel.hour)
                                                ? Container(
                                                    padding: EdgeInsets.all(
                                                        SizeConfig.defaultSize *
                                                            1.9),
                                                    color: Color(0xff52505B),
                                                    child: SizedBox(),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.all(
                                                        SizeConfig.defaultSize *
                                                            1.9),
                                                    color: Colors.orange,
                                                    child: SizedBox(),
                                                  )));
                              }),
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
                                  style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 1.5),
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
                              // Remove this deubgging shit
                              InkWell(
                                child: Container(
                                  child: Icon(Icons.arrow_back),
                                ),
                                onTap: () {
                                  print(_bookingServices.selTime);
                                },
                              )
                            ]),
                          ),
                          // End Of Seat Picker
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
