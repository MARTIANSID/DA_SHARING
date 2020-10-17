import 'package:flutter/material.dart';

class ThemeConstants {
  static const BGCOLOR_DARK = Color(0xFF171C33);
  static const ACCENT = Colors.redAccent;
  static const BGCOLOR_DARK_COMP = Color(0xFF282C49);
  static const TEXT_CHAT_TAG = Color(0xFFD066D4);
  static const TEXT_CHAT_ACTIVE = Color(0xFF04F6E7);
  static const ROOMS_MENU_TEXT_STYLE = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w800,
      fontFamily: 'PS');

  static const Color MENU_NOT_SELECTED = Color(0xFF555555);

  static LinearGradient PURPLE_GRADIENT = LinearGradient(
      List: [Color(0xFF4E57F2), Color(0xFF973FF5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static LinearGradient WHITE_GRADIENT = LinearGradient(
    List: [Colors.transparent, Colors.transparent],
  );

  static const Color RIGHT_CHAT_BUBBLE = Color(0xFF2233AA);
  static const Color LEFT_CHAT_BUBBLE_PRIVATE = Color(0xFF112255);
  // Color(0xFF2233AA);

}
