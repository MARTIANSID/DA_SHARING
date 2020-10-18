import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String name;
  String email;
  String id;
  String image;

  User({this.email, this.id, this.name, this.image});
}

// Logged in user info

class UserManage with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User user;
  Future<void> getUser({user, username, google, password, email}) async {
    print("here4");
    print(user);
    this.user = User(
        email: user.email,
        name: google ? user.displayName : username,
        image: google ? user.photoUrl : '',
        id: user.uid);
    print("hererere");
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    print("here3");
    prefs.setBool('google', google);
    if (google == false) {
      prefs.setString('email', email);
      prefs.setString('password', password);
      prefs.setString('username', username);
    }
    // prefs.setString('email', email);
  }

  Future<dynamic> signIn(String email, String password) async {
    email = email.trim();
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      print("" + user.toString());
      return user;
    } catch (er) {}
    // } catch (e) {
    //   print(e.toString());
    //   if (e.toString().contains("ERROR_WRONG_PASSWORD"))

    //   else if (e.toString().contains("ERROR_USER_NOT_FOUND"))
    //     setSnackbarText("User not found");
    //   else if (e.toString().contains("ERROR_INVALID_EMAIL"))
    //     setSnackbarText("Your email address is improperly formatted");
    //   else
    //     setSnackbarText("${e.toString()}");
    //   return null;
    // }
  }
}
