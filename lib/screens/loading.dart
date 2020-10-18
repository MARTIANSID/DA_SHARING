import 'package:flutter/material.dart';
import 'package:videoPlayer/constants/themes.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(color: ThemeConstants.BGCOLOR_DARK),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }
}
