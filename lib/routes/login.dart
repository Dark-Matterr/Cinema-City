import 'package:cinema_city/constant.dart';
import 'package:cinema_city/size_config.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.18),
          child: Column(children: [
            //Welcome Text
            Container(
              child: Text(
                "WELCOME TO",
                style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.7,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // Title Text
            Container(
              child: Text(
                "Cinema City",
                style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 4,
                    fontWeight: FontWeight.bold,
                    color: cPrimaryColor),
              ),
            ),
            //Login Form
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.09),
              width: SizeConfig.screenWidth * 0.8,
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    // Email address textfield
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight * 0.01),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffc1071e))),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: "Email Address",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    // Password textfield
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight * 0.01),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffc1071e))),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    // Login Button
                    Container(
                      width: SizeConfig.screenHeight,
                      margin: EdgeInsets.only(top: SizeConfig.defaultSize),
                      child: RaisedButton(
                        textColor: Colors.white,
                        child: Text(
                          "Sign In",
                          style:
                              TextStyle(fontSize: SizeConfig.defaultSize * 2),
                        ),
                        color: cPrimaryColor,
                        onPressed: () {},
                      ),
                    ),
                    //Register Button
                    Container(
                      width: SizeConfig.screenHeight,
                      child: RaisedButton(
                        textColor: Colors.white,
                        child: Text("Register",
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 2)),
                        color: cSecondaryColor,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
