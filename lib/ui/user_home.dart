import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projucti_sample/res/custom_colors.dart';
import 'package:projucti_sample/widgets/app_bar_title.dart';
import 'package:projucti_sample/widgets/google_sign_out_button.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.loginPageBackground,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: CustomColor.loginPageBackground,
          title: AppBarTitle(
            sectionName: _user.displayName!,
          ),
          actions: <Widget>[
            GoogleSignOutButton(),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Welcome " + _user.displayName!)],
          ),
        ),
      ),
    );
  }
}
