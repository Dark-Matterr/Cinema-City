import 'package:cinema_city/provider/booking.dart';
import 'package:cinema_city/provider/movie.dart';
import 'package:cinema_city/provider/ticket.dart';
import 'package:cinema_city/widgets/alertdialogbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constant.dart';
import '../routes.dart';
import '../size_config.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingServices(),
      child: BookingScreenChild(),
    );
  }
}

class BookingScreenChild extends StatelessWidget {
  const BookingScreenChild();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _bookService = Provider.of<BookingServices>(context, listen: false);
    // Get the index movie cache in Movie Services
    return Consumer<MovieServices>(
      builder: (_, movieCache, __) => FutureBuilder(
          future: _bookService
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
                                    fontSize: SizeConfig.defaultSize * 1.8,
                                  ),
                                  dropdownColor: Color(0xff4f4f4f),
                                  // Value setter
                                  value: cache.selDate,
                                  // Drop Down value onchange
                                  onChanged: (newVal) {
                                    cache.selDate = newVal;
                                    cache.totalSeatReset();
                                    cache.selTime = (cache.selTime == null)
                                        ? cache.distinctTime(
                                            cache.selDate, snapshot.data)[0]
                                        : cache.selTime;
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
                          Consumer<BookingServices>(builder: (_, cache, __) {
                            if (cache
                                .distinctTime(cache.selDate, snapshot.data)
                                .isNotEmpty) {
                              return Container(
                                child: ToggleSwitch(
                                    fontSize: SizeConfig.defaultSize * 1.5,
                                    initialLabelIndex:
                                        (cache.index == -1) ? 0 : cache.index,
                                    minWidth: SizeConfig.defaultSize * 9,
                                    minHeight: SizeConfig.defaultSize * 5,
                                    activeBgColor: cButtonColor,
                                    labels: cache.toggleLabels(snapshot.data),
                                    onToggle: (index) {
                                      // Set selected date in Booking Service
                                      cache.selTime = cache.distinctTime(
                                          cache.selDate, snapshot.data)[index];
                                      cache.index = index;
                                      //Switching date reset total amount
                                      cache.totalSeatReset();
                                    }),
                              );
                            }
                            return Container(
                              child: ToggleSwitch(
                                initialLabelIndex: 0,
                                fontSize: SizeConfig.defaultSize * 1.5,
                                minWidth: SizeConfig.defaultSize * 15,
                                minHeight: SizeConfig.defaultSize * 5,
                                activeBgColor: cButtonColor,
                                labels: ["No Time Slot"],
                              ),
                            );
                          }),
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
                                return FutureBuilder(
                                  future: cache.getOccupiedSeats(movieCache
                                      .movie[movieCache.index].id
                                      .toString()),
                                  builder: (context, snapshotSeat) {
                                    // If the Date and TIme data is ready then proceed to picking seats
                                    if (snapshotSeat.hasData) {
                                      return Wrap(
                                          runSpacing:
                                              SizeConfig.defaultSize * 1.2,
                                          spacing: SizeConfig.defaultSize * 1,
                                          alignment: WrapAlignment.center,
                                          children: List.generate(40, (index) {
                                            if (snapshotSeat.data
                                                .contains(index)) {
                                              return Container(
                                                padding: EdgeInsets.all(
                                                    SizeConfig.defaultSize *
                                                        1.9),
                                                color: Colors.black,
                                                child: SizedBox(),
                                              );
                                            }
                                            return InkWell(
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    SizeConfig.defaultSize *
                                                        1.9),
                                                color:
                                                    (cache.seatsToggle[index])
                                                        ? cButtonColor
                                                        : Color(0xff52505B),
                                                child: SizedBox(),
                                              ),
                                              onTap: () {
                                                cache.pickSeats = index;
                                              },
                                            );
                                          }));
                                    }
                                    // The Data is not Ready then output some waiting values
                                    else {
                                      return Wrap(
                                          runSpacing:
                                              SizeConfig.defaultSize * 1.2,
                                          spacing: SizeConfig.defaultSize * 1,
                                          alignment: WrapAlignment.center,
                                          children: List.generate(40, (index) {
                                            return Container(
                                              padding: EdgeInsets.all(
                                                  SizeConfig.defaultSize * 1.9),
                                              color: Colors.grey[800],
                                              child: SizedBox(),
                                            );
                                          }));
                                    }
                                  },
                                );
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
                            ]),
                          ),
                          // End Of Seat Picker
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Consumer<BookingServices>(
                  builder: (_, cache, __) => Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.all(SizeConfig.defaultSize * 2),
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize * 2,
                            horizontal: SizeConfig.defaultSize * 2,
                          ),
                          color: cButtonColor,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TOTAL: ",
                                  style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 1.8,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "PHP ${cache.totalPrice(movieCache.movie[movieCache.index].price.toDouble())}",
                                  style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.8,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ]),
                        ),
                        Consumer<TicketCache>(
                          builder: (_, ticketCache, __) => ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(cAccents),
                            ),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.defaultSize * 2,
                                  horizontal: SizeConfig.defaultSize * 2,
                                ),
                                child: Icon(Icons.arrow_forward)),
                            onPressed: () async {
                              int codeStatus = await cache.bookSeatNow(
                                movieCache.movie[movieCache.index].id,
                                movieCache.movie[movieCache.index].title,
                                movieCache.movie[movieCache.index].price,
                              );

                              if (codeStatus == 1) {
                                // Cache the values from ticket provider
                                ticketCache.selSeats = cache.selectedSeats();
                                ticketCache.movieTitle =
                                    movieCache.movie[movieCache.index].title;
                                ticketCache.runtime = cache.selTime;
                                ticketCache.movieGenre = movieCache
                                    .movie[movieCache.index].genre
                                    .split(",");
                                ticketCache.ticketId =
                                    await cache.generateTicketId(
                                        movieCache.movie[movieCache.index].id);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    RouteGenerator.ticketPage, (x) => false);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialog(
                                        title: "Please check and choose wisely",
                                        body:
                                            "Please pick some seats or schedule for your reservation.",
                                        actionText: "Ok",
                                        onPress: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(child: Image.asset("assets/icons/ripple.gif"));
          }),
    );
  }
}
