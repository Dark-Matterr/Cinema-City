import 'package:cinema_city/constant.dart';
import 'package:cinema_city/widgets/rectangle_button.dart';
import 'package:cinema_city/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class RegistrationScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _password = TextEditingController();
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
                  "Create an account",
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
                      CustomTextField(
                        text: "Email Address",
                        color: cSecondaryColor,
                        control: _email,
                        secured: false,
                      ),
                      // First Name TextField
                      CustomTextField(
                        text: "First Name",
                        color: cSecondaryColor,
                        control: _fname,
                        secured: false,
                      ),
                      // Last Name TextField
                      CustomTextField(
                        text: "Last Name",
                        color: cSecondaryColor,
                        control: _lname,
                        secured: false,
                      ),
                      // Password TextField
                      CustomTextField(
                        text: "Password",
                        color: cSecondaryColor,
                        control: _password,
                        secured: true,
                      ),
                      // Retype Password TextField
                      CustomTextField(
                        text: "Retype the password",
                        color: cSecondaryColor,
                        secured: true,
                      ),
                      // Rounded Register Button
                      Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                        child: RectangleButton(
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
