import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: SizeConfig.defaultSize * 2),
              width: SizeConfig.defaultSize * 25,
              height: SizeConfig.defaultSize * 25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/no-wifi.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: SizeConfig.defaultSize * 1.5),
              child: Text(
                "No Internet Connection",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize * 3,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "You are not connected to the internet. Make sure Wi-Fi/Data is on.",
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.defaultSize * 1.8,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
