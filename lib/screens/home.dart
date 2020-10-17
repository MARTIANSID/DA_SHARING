import 'package:flutter/material.dart';
import 'package:videoPlayer/screens/chatRoom.dart';
import 'package:videoPlayer/screens/profile.dart';
import 'package:videoPlayer/screens/upload.dart';
import '../constants/themes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final widgetOptions = [
    Profile(),
    Upload(),
    ChatRoom(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(gradient: ThemeConstants.PURPLE_GRADIENT),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ThemeConstants.BGCOLOR_DARK_COMP,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          }, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Messages'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_upload),
              title: Text('Profile'),
            ),
          ],
          elevation: 4,
        ),
      ),
    );
  }
}
