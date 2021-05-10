import 'package:barcode_widget/barcode_widget.dart';
import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/booking.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<BookingServices>(
      builder: (_, cache, __) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            leading: InkWell(
          child: Icon(Icons.close),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteGenerator.homePage, (route) => false);
          },
        )),
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/martian.jpg"),
              fit: BoxFit.cover,
            )),
            child: Stack(children: [
              Container(
                color: Colors.black.withOpacity(0.3),
              ),
              Positioned(
                  width: SizeConfig.screenWidth,
                  bottom: 1,
                  child: Column(children: [
                    Container(
                      child: Image(
                        image: AssetImage(
                          "assets/icons/check.png",
                        ),
                        width: SizeConfig.defaultSize * 15,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 5,
                    ),
                    Container(
                      child: Text(
                        "You Reserve The Seats You Want!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 3,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize * 3,
                        vertical: SizeConfig.defaultSize * 2,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.defaultSize * 1.5,
                        horizontal: SizeConfig.defaultSize * 2,
                      ),
                      color: cButtonColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Action Adventure",
                                  style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.5,
                                  ),
                                ),
                                Text(
                                  "Ticket 1/2",
                                  style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.5,
                                  ),
                                ),
                              ]),

                          SizedBox(
                            height: SizeConfig.defaultSize * 2.5,
                          ),
                          //Movie Title
                          Text(
                            "The Hunger Games: Mocking Jay Part 2",
                            style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 3.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.defaultSize * 2.5,
                          ),
                          //Reservation Info
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "6:30 PM RUNTIME",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.defaultSize * 1.8),
                                ),
                                Text(
                                  "SEAT #21",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.defaultSize * 1.8),
                                ),
                              ]),
                          SizedBox(
                            height: SizeConfig.defaultSize * 2.5,
                          ),
                          // Barcode
                          BarcodeWidget(
                            height: SizeConfig.defaultSize * 6,
                            data: '32142021',
                            barcode: Barcode.code128(),
                          ),
                        ],
                      ),
                    ),
                  ])),
            ]),
          ),
        ),
      ),
    );
  }
}
