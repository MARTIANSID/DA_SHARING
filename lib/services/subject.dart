import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:videoPlayer/constants/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final List subsjectList = [
  chipDesign("Operating Systems", Color(0xFF4fc3f7)),
  chipDesign("Physics", Color(0xFFffb74d)),
  chipDesign("DLD", Color(0xFFff8a65)),
  chipDesign("Data structures and algorithms", Color(0xFF9575cd)),
  chipDesign("Engineering Chemistry", Color(0xFF4db6ac)),
  chipDesign("", Color(0xFFf06292)),
  chipDesign("IIP", Color(0xFFa1887f)),
  chipDesign("Applied Linear Algebra", Color(0xFF90a4ae)),
  chipDesign("Signals", Color(0xFFba68c8)),
];

Map<int, String> subjects = subsjectList.asMap();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    void printer() {
      print(subjects.toString());
    }

    TextDecoration decord;

    return Scaffold(
      backgroundColor: ThemeConstants.BGCOLOR_DARK,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.04,
              top: size.height * 0.04,
            ),
            child: Text(
              'Select any five subjects',
              style: TextStyle(
                  decoration: decord,
                  color: ThemeConstants.TEXT_CHAT_ACTIVE,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          divider(context),
          Wrap(
            spacing: 0.0, // gap between adjacent chips
            runSpacing: 0.0, // gap between lines
            children: [
              chipDesign("Operating Systems", Color(0xFF4fc3f7)),
              chipDesign("Physics", Color(0xFFffb74d)),
              chipDesign("DLD", Color(0xFFff8a65)),
              chipDesign("Data structures and algorithms", Color(0xFF9575cd)),
              chipDesign("Engineering Chemistry", Color(0xFF4db6ac)),
              chipDesign("AEC", Color(0xFFf06292)),
              chipDesign("IIP", Color(0xFFa1887f)),
              chipDesign("Applied Linear Algebra", Color(0xFF90a4ae)),
              chipDesign("Signals", Color(0xFFba68c8)),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: printer,
      ),
    );
  }
}

Widget chipDesign(String label, Color color) => Container(
      child: ActionChip(
        onPressed: () {
          return Text('Risjabh');
        },
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        elevation: 3,
        shadowColor: Colors.grey[50],
        padding: EdgeInsets.all(4),
      ),
      margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
    );

///Method to create a divider with added margin
Container divider(BuildContext context) => Container(
      child: Divider(
        color: Colors.pink,
      ),
      margin: EdgeInsets.only(left: 10, right: 10, top: 28, bottom: 28),
    );
