import 'package:barcode_widget/barcode_widget.dart';
import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/connectivity.dart';
import 'package:cinema_city/provider/ticket.dart';
import 'package:cinema_city/routes/no_internet.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityServices>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityServices>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return (model.isOnline)
            ? Consumer<TicketServices>(
                builder: (_, tickProv, __) => FutureBuilder(
                    future: tickProv.getPurchaseHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Scaffold(
                          resizeToAvoidBottomInset: false,
                          appBar: AppBar(),
                          body: Container(
                            child: Column(children: [
                              Expanded(
                                child: ScrollSnapList(
                                  onItemFocus: (index) {},
                                  itemSize: SizeConfig.screenWidth,
                                  padding: EdgeInsets.zero,
                                  itemCount: snapshot
                                      .data[tickProv.index].seatNum.length,
                                  curve: Curves.easeInOut,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: SizeConfig.screenWidth,
                                      height: SizeConfig.screenHeight,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Cinema City
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    SizeConfig.defaultSize * 3),
                                            padding: EdgeInsets.only(
                                              top: SizeConfig.defaultSize * 10,
                                            ),
                                            child: Text(
                                              "Cinema City",
                                              style: TextStyle(
                                                fontSize:
                                                    SizeConfig.defaultSize * 5,
                                                color: Colors.red,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          //Ticket
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    SizeConfig.defaultSize * 3),
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  SizeConfig.defaultSize * 2,
                                              vertical:
                                                  SizeConfig.defaultSize * 2,
                                            ),
                                            color: cButtonColor,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("ACTION ADVENTURE"),
                                                    Text(
                                                        "TICKET ${index + 1}/${snapshot.data[tickProv.index].seatNum.length}"),
                                                  ],
                                                ),
                                                //Ticket Movie Title
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top:
                                                        SizeConfig.defaultSize *
                                                            3,
                                                  ),
                                                  child: Text(
                                                    snapshot
                                                        .data[tickProv.index]
                                                        .movieTitle,
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .defaultSize *
                                                          3.2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Ticket info
                                          Container(
                                            margin: EdgeInsets.only(
                                                top:
                                                    SizeConfig.defaultSize * 3),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    // Time
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Time",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          DateFormat.jm()
                                                              .format(snapshot
                                                                  .data[tickProv
                                                                      .index]
                                                                  .schedDate),
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .defaultSize *
                                                                1.5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    //Seat Number
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Seating",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          "#${snapshot.data[tickProv.index].seatNum[index]}",
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .defaultSize *
                                                                1.5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Date
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Valid Date",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          DateFormat.yMMMMd()
                                                              .format(snapshot
                                                                  .data[tickProv
                                                                      .index]
                                                                  .schedDate),
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .defaultSize *
                                                                1.5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                //Atendee Name
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .defaultSize *
                                                          3),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Attendee Name",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data[
                                                                tickProv.index]
                                                            .customerName,
                                                        style: TextStyle(
                                                          fontSize: SizeConfig
                                                                  .defaultSize *
                                                              1.8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Ticket Barcode
                                          Container(
                                            color: cButtonColor,
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.defaultSize * 1.5,
                                              horizontal:
                                                  SizeConfig.defaultSize * 4,
                                            ),
                                            height: SizeConfig.defaultSize * 9,
                                            child: BarcodeWidget(
                                              data: snapshot
                                                  .data[tickProv.index].ticketId
                                                  .toString(),
                                              barcode: Barcode.code128(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ]),
                          ),
                        );
                      }
                      return Scaffold(
                          body: Center(
                              child: SpinKitCircle(
                        color: cPrimaryColor,
                        size: SizeConfig.defaultSize * 8,
                      )));
                    }),
              )
            : NoInternetScreen();
      } else {
        return Scaffold(
            body: Center(
                child: SpinKitCircle(
          color: cPrimaryColor,
          size: SizeConfig.defaultSize * 8,
        )));
      }
    });
  }
}
