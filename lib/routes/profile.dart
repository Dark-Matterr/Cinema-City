import 'package:cinema_city/provider/connectivity.dart';
import 'package:cinema_city/provider/user.dart';
import 'package:cinema_city/routes/no_internet.dart';
import 'package:cinema_city/widgets/alertdialogbox.dart';
import 'package:cinema_city/widgets/rectangle_button.dart';
import 'package:cinema_city/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../routes.dart';
import '../size_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserServices(),
      child: ProfileChild(),
    );
  }
}

class ProfileChild extends StatefulWidget {
  const ProfileChild();
  @override
  _ProfileChildState createState() => _ProfileChildState();
}

class _ProfileChildState extends State<ProfileChild> {
  final _key = GlobalKey<FormState>();
  final _currentpassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _retpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityServices>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserServices>(context);
    return Consumer<ConnectivityServices>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return (model.isOnline)
            ? FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Scaffold(
                      appBar: AppBar(
                          title: RichText(
                              text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Update Password\n',
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.8)),
                        TextSpan(
                            text: '${snapshot.data.getString('user_email')}',
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.5)),
                      ]))),
                      body: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.defaultSize * 3,
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.9,
                              child: Form(
                                key: _key,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Current Password",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.defaultSize * 1.4),
                                      ),
                                    ),
                                    CustomTextField(
                                      control: _currentpassword,
                                      text: "Enter your current password",
                                      color: Colors.white,
                                      margin: SizeConfig.defaultSize * 0.3,
                                      secured: true,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.defaultSize * 1.5),
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "New Password",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.defaultSize * 1.4),
                                      ),
                                    ),
                                    CustomTextField(
                                      control: _newpassword,
                                      text: "Enter your new password",
                                      color: Colors.grey,
                                      secured: true,
                                      margin: SizeConfig.defaultSize * 0.3,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.defaultSize * 1.5),
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Confirm Password",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.defaultSize * 1.4),
                                      ),
                                    ),
                                    CustomTextField(
                                      control: _retpassword,
                                      text: "Retype the password",
                                      color: Colors.white,
                                      margin: SizeConfig.defaultSize * 0.3,
                                      secured: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.defaultSize * 2,
                                  vertical: SizeConfig.defaultSize * 2),
                              child: RectangleButton(
                                  text: "Update Password",
                                  color: cSecondaryColor,
                                  onPress: () async {
                                    if (_currentpassword.text.isNotEmpty &&
                                        _newpassword.text.isNotEmpty &&
                                        _retpassword.text.isNotEmpty) {
                                      if (_newpassword.text.length > 8 &&
                                          _retpassword.text.length > 8) {
                                        if (_newpassword.text ==
                                            _retpassword.text) {
                                          var result = await _userProvider
                                              .changePassword(
                                            snapshot.data.getInt("user_id"),
                                            snapshot.data
                                                .getString("user_email"),
                                            _currentpassword.text,
                                            _newpassword.text,
                                          );
                                          if (result == 1) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomAlertDialog(
                                                    title:
                                                        "The password has been changed",
                                                    body:
                                                        "I hope you secured account. Thanks",
                                                    actionText: "Ok",
                                                    onPress: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              RouteGenerator
                                                                  .homePage);
                                                    },
                                                  );
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomAlertDialog(
                                                    title:
                                                        "Current Password Didn't Match",
                                                    body:
                                                        "Please check your inputs",
                                                    actionText: "Try Again",
                                                    onPress: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                });
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomAlertDialog(
                                                  title:
                                                      "Passwords didn't match in validation",
                                                  body:
                                                      "Please check your inputs in retype and new password",
                                                  actionText: "Try Again",
                                                  onPress: () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              });
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
                                          builder: (context) {
                                            return CustomAlertDialog(
                                              title: "Empty Input Form",
                                              body:
                                                  "Please fill up all the asking inputs in the form",
                                              actionText: "Try Again",
                                              onPress: () {
                                                Navigator.pop(context);
                                              },
                                            );
                                          });
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Scaffold(
                    appBar: AppBar(),
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })
            : NoInternetScreen();
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
