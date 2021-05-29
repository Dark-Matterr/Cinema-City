import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/connectivity.dart';
import 'package:cinema_city/provider/user.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/routes/no_internet.dart';
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
      create: (context) => UserServices(),
      child: LoginChildWdiget(),
    );
  }
}

class LoginChildWdiget extends StatefulWidget {
  const LoginChildWdiget();
  @override
  _LoginChildWdigetState createState() => _LoginChildWdigetState();
}

class _LoginChildWdigetState extends State<LoginChildWdiget> {
  final _key = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityServices>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    final _loginProvider = Provider.of<UserServices>(context);
    SizeConfig().init(context);
    return Consumer<ConnectivityServices>(builder: (context, model, children) {
      if (model.isOnline != null) {
        return (model.isOnline)
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                body: (!isLoading)
                    ? Center(
                        child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.screenHeight * 0.05),
                                  width: SizeConfig.screenWidth * 0.8,
                                  child: Form(
                                    key: _key,
                                    child: Column(
                                      children: [
                                        // Email address textfield
                                        CustomTextField(
                                          text: "Email Address",
                                          color: Colors.white,
                                          icon: Icons.person,
                                          secured: false,
                                          margin:
                                              SizeConfig.screenHeight * 0.01,
                                          control: _email,
                                        ),
                                        // Password textfield
                                        CustomTextField(
                                          text: "Password",
                                          color: Colors.white,
                                          icon: Icons.vpn_key,
                                          secured: true,
                                          margin:
                                              SizeConfig.screenHeight * 0.01,
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
                                                    var _result =
                                                        await _loginProvider
                                                            .login(
                                                      email: _email.text,
                                                      password: _password.text,
                                                    );
                                                    isLoading = false;
                                                    // Username and password match
                                                    if (_result == 0 ||
                                                        _email.text.isEmpty ||
                                                        _password
                                                            .text.isEmpty) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CustomAlertDialog(
                                                              title:
                                                                  "Incorrect email or password",
                                                              body:
                                                                  "Please check your inputs.",
                                                              actionText:
                                                                  "Try Again",
                                                              onPress: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            );
                                                          });
                                                    }
                                                    // Incorrect Username or password
                                                    else {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              RouteGenerator
                                                                  .homePage);
                                                    }
                                                  }),
                                              SizedBox(
                                                height:
                                                    SizeConfig.defaultSize * 3,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top:
                                                        SizeConfig.defaultSize *
                                                            0.001),
                                                child: Row(children: [
                                                  Expanded(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .defaultSize *
                                                              0.1,
                                                          right: SizeConfig
                                                                  .defaultSize *
                                                              0.1,
                                                        ),
                                                        child: Divider(
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  Text(
                                                    "Don't have an account?",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .defaultSize *
                                                            1.5,
                                                        color: Colors.grey),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .defaultSize *
                                                              0.1,
                                                          right: SizeConfig
                                                                  .defaultSize *
                                                              0.1,
                                                        ),
                                                        child: Divider(
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                ]),
                                              ),
                                              //Register Button
                                              RectangleButton(
                                                text: "Create new account",
                                                color: cSecondaryColor,
                                                onPress: () =>
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            RouteGenerator
                                                                .registerPage),
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
                    : Scaffold(
                        body: Center(
                          child: Image.asset("assets/icons/ripple.gif"),
                        ),
                      ),
              )
            : NoInternetScreen();
      } else {
        return Scaffold(
            body: Center(child: Image.asset("assets/icons/ripple.gif")));
      }
    });
  }
}
