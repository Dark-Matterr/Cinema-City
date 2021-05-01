import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/login_model.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/rounded_button.dart';
import 'package:cinema_city/widgets/rounded_textcontainer.dart';
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
      create: (context) => LoginModel(),
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
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginModel>(context, listen: false);
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
            Container(child: TitleWidget(4.0)),
            //Login Form
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
              width: SizeConfig.screenWidth * 0.8,
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    // Email address textfield
                    TextContainer(
                      child: TextFormField(
                        controller: _email,
                        style: TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: "Email Address",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    // Password textfield
                    TextContainer(
                      child: TextFormField(
                        controller: _password,
                        obscureText: true,
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
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                      child: Column(
                        children: [
                          // Login Button
                          RoundedButton(
                            text: "Sign In",
                            color: cPrimaryColor,
                            onPress: () => print("x"),
                          ),
                          //Register Button
                          RoundedButton(
                            text: "Sign Up",
                            color: cSecondaryColor,
                            onPress: () => print("x"),
                          )
                        ],
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
