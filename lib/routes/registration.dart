import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/user.dart';
import 'package:cinema_city/widgets/alertdialogbox.dart';
import 'package:cinema_city/widgets/rectangle_button.dart';
import 'package:cinema_city/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen();
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserServices(),
      child: RegistrationChildWdiget(),
    );
  }
}

class RegistrationChildWdiget extends StatefulWidget {
  @override
  _RegistrationChildWdiget createState() => _RegistrationChildWdiget();
}

class _RegistrationChildWdiget extends State<RegistrationChildWdiget> {
  final _key = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _regprovider = Provider.of<UserServices>(context);
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.11),
          child: Column(
            children: [
              // User Image
              Lottie.asset(
                "assets/otp.json",
                height: SizeConfig.defaultSize * 20,
              ),
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
                          onPress: () async {
                            int result = await _regprovider.register(
                              email: _email.text,
                              fname: _fname.text,
                              lname: _lname.text,
                              password: _password.text,
                            );
                            if (result == 1) {
                              showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                  title: "Registered Successfully",
                                  body: "You can now login to the cinema city!",
                                  actionText: "Ok",
                                  onPress: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            } else if (result == 0) {
                              showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                  title:
                                      "The email was already exist in the database",
                                  body:
                                      "Please try different email address or login with this existing account.",
                                  actionText: "Login",
                                  onPress: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }
                          },
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
