import 'package:cinema_city/provider/user.dart';
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
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserServices>(context);
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Container(
                child: Column(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.defaultSize * 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            Color(0xffec7532),
                            Color(0xfffbbd61),
                          ],
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: SizeConfig.defaultSize * 5,
                              backgroundImage:
                                  AssetImage("assets/icons/user.png"),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize * 1.5,
                            ),
                            Text(
                              "${snapshot.data.getString("user_fname")} ${snapshot.data.getString("user_lname")}",
                              style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
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
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.defaultSize * 1.1,
                                vertical: SizeConfig.defaultSize * 1.2,
                              ),
                              width: SizeConfig.screenWidth,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.grey,
                              ))),
                              child: Row(children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: SizeConfig.defaultSize * 1,
                                ),
                                Text(
                                  "${snapshot.data.getString("user_email")}",
                                  style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.5,
                                  ),
                                ),
                              ]),
                            ),
                            CustomTextField(
                              control: _currentpassword,
                              text: "Current Password",
                              color: Colors.white,
                              icon: Icons.vpn_key,
                              secured: true,
                            ),
                            CustomTextField(
                              control: _newpassword,
                              text: "New Password",
                              color: Colors.white,
                              icon: Icons.change_history,
                              secured: true,
                            ),
                            CustomTextField(
                              control: _retpassword,
                              text: "Retype Password",
                              color: Colors.white,
                              icon: Icons.security,
                              secured: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: RectangleButton(
                  text: "Update Account",
                  color: cSecondaryColor,
                  onPress: () async {
                    if (_currentpassword.text.isNotEmpty &&
                        _newpassword.text.isNotEmpty &&
                        _retpassword.text.isNotEmpty) {
                      if (_newpassword.text == _retpassword.text) {
                        var result = await _userProvider.changePassword(
                          snapshot.data.getInt("user_id"),
                          snapshot.data.getString("user_email"),
                          _currentpassword.text,
                          _newpassword.text,
                        );
                        if (result == 1) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                  title: "The password has been changed",
                                  body: "I hope you secured account. Thanks",
                                  actionText: "Ok",
                                  onPress: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        RouteGenerator.homePage);
                                  },
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                  title: "Current Password Didn't Match",
                                  body: "Please check your inputs",
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
                                title: "Passwords didn't match in validation",
                                body:
                                    "Please check your inputs in retype and new password",
                                actionText: "Try Again",
                                onPress: () {
                                  Navigator.pop(context);
                                },
                              );
                            });
                      }
                    }
                  }),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
