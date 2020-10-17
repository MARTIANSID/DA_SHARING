import 'package:flutter/material.dart';
import '../constants/themes.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: ThemeConstants.BGCOLOR_DARK,
      ),
      child: Center(child: Text("Profile")),
    );
  }
}
