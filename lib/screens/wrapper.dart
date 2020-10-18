import 'package:flutter/material.dart';
import 'package:videoPlayer/screens/authenticate/authenticate.dart';
import 'package:videoPlayer/screens/home.dart';
import 'package:videoPlayer/screens/home/home_demo.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return either home aur auth
    return AuthentiCate();
  }
}
