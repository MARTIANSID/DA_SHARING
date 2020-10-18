import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videoPlayer/screens/authenticate/AuthService.dart';
import 'package:videoPlayer/screens/authenticate/user.dart';
import 'package:videoPlayer/screens/home.dart';
// import 'package:videoPlayer/screens/profile.dart';
import 'package:videoPlayer/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    Future<bool> checkIfdc(auth) async {
      print("hello");
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      print("heere");
      if (prefs.containsKey('google')) {
        if (prefs.getBool('google')) {
          GoogleSignInAccount acc = await googleSignIn.signInSilently();
          await auth.getUser(
            user: acc,
            google: true,
          );
          return false;
        } else {
          print("here2");
          String email = prefs.getString("email");
          String password = prefs.getString("password");
          String username = prefs.getString("username");
          print(email);
          print(password);
          var user = await auth.signIn(email, password);
          await auth.getUser(
              user: user,
              email: email,
              password: password,
              google: false,
              username: username);

          return true;
        }
      } else {
        return false;
      }
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthService()),
          ChangeNotifierProvider.value(value: UserManage())
        ],
        child: Consumer<UserManage>(
          builder: (ctx, auth, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: FutureBuilder(
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('wait');
                    } else {
                      if (snapshot.data) {
                        return Home();
                      } else {
                        return Wrapper();
                      }
                    }
                  },
                  future: checkIfdc(auth))),
        ));
  }
}
