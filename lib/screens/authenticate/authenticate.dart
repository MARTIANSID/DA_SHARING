import 'package:flutter/material.dart';
import 'package:videoPlayer/screens/authenticate/sign_in.dart';

class AuthentiCate extends StatefulWidget {
  AuthentiCate({Key key}) : super(key: key);

  @override
  _AuthentiCateState createState() => _AuthentiCateState();
}

class _AuthentiCateState extends State<AuthentiCate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}
