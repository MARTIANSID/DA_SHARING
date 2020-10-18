import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoPlayer/screens/authenticate/user.dart';

import '../home.dart';
import 'AuthService.dart';

class VerifyEmail extends StatefulWidget {
  final user;
  String username;
  String password;
  String email;
  VerifyEmail(this.user, this.username, this.password, this.email);
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isAuthenticated = false;
  bool retry = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      bool isAuth = await Provider.of<AuthService>(context, listen: false)
          .sendVerificationLink();
      if (isAuth) {
        Provider.of<UserManage>(context, listen: false).getUser(
            user: widget.user,
            username: widget.username,
            google: false,
            password: widget.password,
            email: widget.email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        retry = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          retry ? Text("Pls Retry") : Text("Verification link has been sent!"),
    );
  }
}
