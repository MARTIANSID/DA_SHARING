import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoPlayer/screens/authenticate/AuthService.dart';
import 'package:videoPlayer/screens/home.dart';
import 'package:videoPlayer/screens/profile.dart';
import 'package:videoPlayer/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
