import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/access_model.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/alertdialogbox.dart';
import 'package:cinema_city/widgets/rectangle_button.dart';
import 'package:cinema_city/widgets/text_field.dart';
import 'package:cinema_city/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccessModel(),
      child: LoginChildWdiget(),
    );
  }
}

class LoginChildWdiget extends StatefulWidget {
  @override
  _LoginChildWdigetState createState() => _LoginChildWdigetState();
}

class _LoginChildWdigetState extends State<LoginChildWdiget> {
  final _key = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _loginProvider = Provider.of<AccessModel>(context);
    SizeConfig().init(context);
    return Scaffold(
        body: (!isLoading)
            ? SingleChildScrollView(
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
                    Container(child: TitleWidget(4.0)),
                    //Login Form
                    Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
                      width: SizeConfig.screenWidth * 0.8,
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            // Email address textfield
                            CustomTextField(
                              text: "Email Address",
                              color: cSecondaryColor,
                              icon: Icons.person,
                              secured: false,
                              control: _email,
                            ),
                            // Password textfield
                            CustomTextField(
                              text: "Password",
                              color: cSecondaryColor,
                              icon: Icons.vpn_key,
                              secured: true,
                              control: _password,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.defaultSize * 2),
                              child: Column(
                                children: [
                                  // Login Button
                                  RectangleButton(
                                      text: "Log In",
                                      color: cPrimaryColor,
                                      onPress: () async {
                                        isLoading = true;
                                        await _loginProvider.login(
                                          email: _email.text,
                                          password: _password.text,
                                        );
                                        isLoading = false;
                                        // Username and password match
                                        if (_loginProvider.getResp == 1) {
                                        }
                                        // Error in http request
                                        else if (_loginProvider.getResp == -1) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomAlertDialog();
                                              });
                                        }
                                        // Incorrect Username or password
                                        else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomAlertDialog();
                                              });
                                        }
                                      }),
                                  //Register Button
                                  RectangleButton(
                                    text: "Register",
                                    color: cSecondaryColor,
                                    onPress: () => print("x"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // AlertBox
                  ]),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
