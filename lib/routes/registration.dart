import 'package:cinema_city/constant.dart';
import 'package:cinema_city/provider/connectivity.dart';
import 'package:cinema_city/provider/user.dart';
import 'package:cinema_city/routes.dart';
import 'package:cinema_city/routes/no_internet.dart';
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
  final _retpass = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityServices>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    final _regprovider = Provider.of<UserServices>(context);
    SizeConfig().init(context);
    return Consumer<ConnectivityServices>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return (model.isOnline)
            ? Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(),
                body: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.11),
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
                              color: Colors.white,
                            ),
                          ),
                        ),

                        //Forms
                        Container(
                          margin:
                              EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                          width: SizeConfig.screenWidth * 0.8,
                          child: Form(
                            key: _key,
                            child: Column(
                              children: [
                                // Email Address TextField
                                CustomTextField(
                                  text: "Email Address",
                                  color: Colors.white,
                                  control: _email,
                                  secured: false,
                                  margin: SizeConfig.screenHeight * 0.01,
                                ),
                                // First Name TextField
                                CustomTextField(
                                  text: "First Name",
                                  color: Colors.white,
                                  control: _fname,
                                  secured: false,
                                  margin: SizeConfig.screenHeight * 0.01,
                                ),
                                // Last Name TextField
                                CustomTextField(
                                  text: "Last Name",
                                  color: Colors.white,
                                  control: _lname,
                                  secured: false,
                                  margin: SizeConfig.screenHeight * 0.01,
                                ),
                                // Password TextField
                                CustomTextField(
                                  text: "Password",
                                  color: Colors.white,
                                  control: _password,
                                  secured: true,
                                  margin: SizeConfig.screenHeight * 0.01,
                                ),
                                // Retype Password TextField
                                CustomTextField(
                                  text: "Retype the password",
                                  color: Colors.white,
                                  control: _retpass,
                                  secured: true,
                                  margin: SizeConfig.screenHeight * 0.01,
                                ),
                                // Rounded Register Button
                                Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.defaultSize * 2),
                                  child: RectangleButton(
                                      color: cSecondaryColor,
                                      text: "Register",
                                      onPress: () async {
                                        if (_email.text.isNotEmpty &&
                                            _fname.text.isNotEmpty &&
                                            _lname.text.isNotEmpty &&
                                            _password.text.isNotEmpty) {
                                          if (_regprovider
                                              .isValidEmail(_email.text)) {
                                            if (_password.text.length > 8 &&
                                                _retpass.text.length > 8) {
                                              if (_password.text ==
                                                  _retpass.text) {
                                                int result =
                                                    await _regprovider.register(
                                                  email: _email.text,
                                                  fname: _fname.text,
                                                  lname: _lname.text,
                                                  password: _password.text,
                                                );
                                                if (result == 1) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomAlertDialog(
                                                      title:
                                                          "Registered Successfully",
                                                      body:
                                                          "You can now login to the cinema city!",
                                                      actionText: "Ok",
                                                      onPress: () {
                                                        Navigator
                                                            .pushNamedAndRemoveUntil(
                                                                context,
                                                                RouteGenerator
                                                                    .loginPage,
                                                                (route) =>
                                                                    false);
                                                      },
                                                    ),
                                                  );
                                                } else if (result == 0) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomAlertDialog(
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
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomAlertDialog(
                                                    title:
                                                        "Both Password Didn't Match",
                                                    body:
                                                        "Please check your inputs",
                                                    actionText: "Login",
                                                    onPress: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              }
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    CustomAlertDialog(
                                                  title:
                                                      "Password Must Be Atleast 8 Characters",
                                                  body:
                                                      "Please think another password!",
                                                  actionText: "Login",
                                                  onPress: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              );
                                            }
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomAlertDialog(
                                                title:
                                                    "Email Address is Invalid",
                                                body:
                                                    "Please try different emails or check your inputs",
                                                actionText: "Login",
                                                onPress: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomAlertDialog(
                                              title: "Don't Leave it Blank",
                                              body:
                                                  "Please fill up all the input fields!",
                                              actionText: "Login",
                                              onPress: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        }
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
