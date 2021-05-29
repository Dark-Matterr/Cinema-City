import 'package:cinema_city/provider/connectivity.dart';
import 'package:cinema_city/provider/ticket.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/routes/no_internet.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen();

  @override
  _PurchaseHistoryScreenState createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
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
                builder: (_, cache, __) => FutureBuilder(
                    future: cache.getPurchaseHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text("Purchases"),
                          ),
                          body: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize * 2,
                              vertical: SizeConfig.defaultSize * 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Now Showing
                                Text(
                                  "Brought Tickets",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: SizeConfig.defaultSize * 1.7,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.defaultSize * 2,
                                ),
                                // Ticket Container
                                Expanded(
                                  child: SizedBox(
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          bool isExpired = (snapshot
                                              .data[index].schedDate
                                              .isAfter(DateTime.now()));
                                          return Container(
                                            margin: EdgeInsets.only(
                                              bottom:
                                                  SizeConfig.defaultSize * 1.5,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                cache.index = index;
                                                Navigator.of(context).pushNamed(
                                                    RouteGenerator.ticketPage);
                                              },
                                              splashColor: Colors.grey,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      SizeConfig.defaultSize *
                                                          1,
                                                  vertical:
                                                      SizeConfig.defaultSize *
                                                          1,
                                                ),
                                                color: (isExpired)
                                                    ? Color(0xff2c2833)
                                                    : Color(0xff27242d),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                          SizeConfig
                                                                  .defaultSize *
                                                              0.8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                      child: Image(
                                                        image: (isExpired)
                                                            ? AssetImage(
                                                                "assets/icons/ticket.png")
                                                            : AssetImage(
                                                                "assets/icons/past-ticket.png"),
                                                        width: SizeConfig
                                                                .defaultSize *
                                                            6,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .defaultSize *
                                                          1.5,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // Ticket movie title
                                                            Text(
                                                              snapshot
                                                                  .data[index]
                                                                  .movieTitle,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .defaultSize *
                                                                          1.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: (isExpired)
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xff7f7f7f)),
                                                            ),
                                                            //Information of Reservation
                                                            Text(
                                                              "${DateFormat('EEEE, d MMM, yyyy').format(snapshot.data[index].dateTransact)}",
                                                              style: TextStyle(
                                                                fontSize: SizeConfig
                                                                        .defaultSize *
                                                                    1.4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: (isExpired)
                                                                    ? Colors
                                                                        .white
                                                                    : Color(
                                                                        0xff7f7f7f),
                                                              ),
                                                            ),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      "${DateFormat.jm().format(snapshot.data[index].dateTransact)}",
                                                                      style: TextStyle(
                                                                          fontSize: SizeConfig.defaultSize *
                                                                              1.4,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color: (isExpired)
                                                                              ? Colors.white
                                                                              : Color(0xff7f7f7f)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.all(
                                                                        SizeConfig.defaultSize *
                                                                            0.5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color: (isExpired)
                                                                              ? Colors.white
                                                                              : Color(0xff7f7f7f)),
                                                                    ),
                                                                    child: Text(
                                                                      "PHP ${snapshot.data[index].price}",
                                                                      style: TextStyle(
                                                                          color: (isExpired)
                                                                              ? Colors.white
                                                                              : Color(0xff7f7f7f)),
                                                                    ),
                                                                  )
                                                                ]),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Scaffold(
                          body: Center(
                            child: Image(
                              image: AssetImage("assets/icons/ripple.gif"),
                            ),
                          ),
                        );
                      }
                    }),
              )
            : NoInternetScreen();
      } else {
        return Scaffold(
            body: Center(child: Image.asset("assets/icons/ripple.gif")));
      }
    });
  }
}
