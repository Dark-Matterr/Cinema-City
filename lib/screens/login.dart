import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/login_model.dart';
import 'package:cinema_city/size_config.dart';
import 'package:cinema_city/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginModel(),
      child: LoginChildWdiget(),
    );
  }
}

class LoginChildWdiget extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final login_provider = Provider.of<LoginModel>(context, listen: false);
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
                        child: Text("Sign In",
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 2)),
                        color: cPrimaryColor,
                        onPressed: () {
                          login_provider.userSignIn();
                          print(login_provider.getresp);
                        },
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
