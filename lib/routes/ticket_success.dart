import 'package:barcode_widget/barcode_widget.dart';
import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/connectivity.dart';
import 'package:cinema_city/provider/ticket.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/routes/no_internet.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketSuccesscreen extends StatefulWidget {
  const TicketSuccesscreen();

  @override
  _TicketSuccesscreenState createState() => _TicketSuccesscreenState();
}

class _TicketSuccesscreenState extends State<TicketSuccesscreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityServices>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<ConnectivityServices>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return (model.isOnline)
            ? Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                    leading: InkWell(
                  child: Icon(Icons.close),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteGenerator.homePage, (route) => false);
                  },
                )),
                body: Consumer<TicketServices>(
                    builder: (_, cache, __) =>
                        Stack(alignment: Alignment.center, children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(cache.movieImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.defaultSize * 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Check Image icon
                                  Image(
                                    image: AssetImage("assets/icons/check.png"),
                                    width: SizeConfig.defaultSize * 12,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.defaultSize * 2,
                                  ),
                                  // Text for reservation
                                  Text(
                                    "You Reserve The Seats You Want!!",
                                    style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 3,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  // Ticket
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: List.generate(
                                      cache.selSeats.length,
                                      (index) => Container(
                                        width: SizeConfig.defaultSize * 30,
                                        height: SizeConfig.defaultSize * 30,
                                        margin: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.defaultSize * 3,
                                          vertical: SizeConfig.defaultSize * 2,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.defaultSize * 2.5,
                                          vertical: SizeConfig.defaultSize * 2,
                                        ),
                                        color: cButtonColor,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    cache.movieGenre.join(" ")),
                                                Text(
                                                    "Ticket ${index + 1}/${cache.selSeats.length}"),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeConfig.defaultSize * 2,
                                            ),
                                            Text(
                                              cache.movieTitle,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    SizeConfig.defaultSize *
                                                        2.6,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeConfig.defaultSize * 2,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  cache.runtime,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        SizeConfig.defaultSize *
                                                            1.5,
                                                  ),
                                                ),
                                                Text(
                                                  "SEAT #${cache.selSeats[index] + 1}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        SizeConfig.defaultSize *
                                                            1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeConfig.defaultSize * 2,
                                            ),
                                            BarcodeWidget(
                                              height:
                                                  SizeConfig.defaultSize * 8,
                                              data: cache.ticketId.toString(),
                                              barcode: Barcode.code128(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])),
              )
            : NoInternetScreen();
      } else {
        return Scaffold(
            body: Center(child: Image.asset("assets/icons/ripple.gif")));
      }
    });
  }
}
