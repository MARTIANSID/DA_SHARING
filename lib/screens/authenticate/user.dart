import 'package:flutter/cupertino.dart';

class User {
  String name;
  String email;
  String id;

  User({this.email, this.id, this.name});
}

// Logged in user info

class UserManage with ChangeNotifier {
  User user;
  void getUser({user, username, google}) {
    this.user = User(
        email: user.email,
        name: google ? user.displayName : username,
        id: user.uid);
  }
}
