import 'package:flutter/material.dart';
import 'package:projucti_sample/ui/sign_in_google.dart';
import 'package:projucti_sample/utils/authentication.dart';

class GoogleSignOutButton extends StatefulWidget {
  @override
  _GoogleSignOutButtonState createState() => _GoogleSignOutButtonState();
}

class _GoogleSignOutButtonState extends State<GoogleSignOutButton> {
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: () async {
        setState(() {
          _isSigningOut = true;
        });
        await Authentication.signOut(context: context);
        setState(() {
          _isSigningOut = false;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SignInGoogle(),
        ));
      },
    );
  }
}
