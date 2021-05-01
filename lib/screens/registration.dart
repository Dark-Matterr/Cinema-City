import 'package:cinema_city/constant.dart';
import 'package:cinema_city/widgets/rounded_button.dart';
import 'package:cinema_city/widgets/rounded_textcontainer.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class RegistrationScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [Icon(Icons.arrow_back)],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.12),
          child: Column(
            children: [
              //Registration Text
              Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.defaultSize * 1,
                    bottom: SizeConfig.defaultSize * 1),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 2.5,
                    fontWeight: FontWeight.bold,
                    color: cSecondaryColor,
                  ),
                ),
              ),
              // User Image
              Image(
                image: AssetImage("assets/icons/soft-drink.png"),
                width: SizeConfig.defaultSize * 14,
              ),

              //Forms
              Container(
                margin: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                width: SizeConfig.screenWidth * 0.8,
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      // Email Address TextField
                      TextContainer(
                        child: TextFormField(
                          //controller: _email,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      // First Name TextField
                      TextContainer(
                        child: TextFormField(
                          //controller: _email,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: "First Name",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      // Last Name TextField
                      TextContainer(
                        child: TextFormField(
                          //controller: _email,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: "Last Name",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      // Password TextField
                      TextContainer(
                        child: TextFormField(
                          //controller: _email,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      // Retype Password TextField
                      TextContainer(
                        child: TextFormField(
                          //controller: _email,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: "Retype Password",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      // Rounded Register Button
                      Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                        child: RoundedButton(
                          color: cSecondaryColor,
                          text: "Register",
                          onPress: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
