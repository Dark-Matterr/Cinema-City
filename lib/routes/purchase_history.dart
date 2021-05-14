import 'package:cinema_city/provider/ticket.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen();
  @override
  Widget build(BuildContext context) {
    return Consumer<TicketServices>(
      builder: (_, cache, __) => FutureBuilder(
          future: cache.getPurchaseHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("PURCHASES"),
                  centerTitle: true,
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
                          height: SizeConfig.screenHeight,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    bottom: SizeConfig.defaultSize * 1.5,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      cache.index = index;
                                      Navigator.of(context)
                                          .pushNamed(RouteGenerator.ticketPage);
                                    },
                                    splashColor: Colors.grey,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.defaultSize * 1,
                                        vertical: SizeConfig.defaultSize * 1,
                                      ),
                                      color: Color(0xff2c2833),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(
                                                SizeConfig.defaultSize * 0.8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/icons/ticket.png"),
                                              width: SizeConfig.defaultSize * 6,
                                            ),
                                          ),
                                          SizedBox(
                                            width: SizeConfig.defaultSize * 1.5,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Ticket movie title
                                                Text(
                                                  snapshot
                                                      .data[index].movieTitle,
                                                  style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.defaultSize *
                                                            1.9,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                //Information of Reservation
                                                Text(
                                                  "${DateFormat('EEEE, d MMM, yyyy').format(snapshot.data[index].schedDate)}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.defaultSize *
                                                            1.4,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  "${DateFormat.jm().format(snapshot.data[index].schedDate)}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.defaultSize *
                                                            1.4,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
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
    );
  }
}
