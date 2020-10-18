import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Any sign in anynymously

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user; //access to the user
      return user;
    } catch (e) {
      print(e.toString());
      return null; //if error happens
    }
  }

  //Sign in with email and password

  // register with email and password

  //sign out

}
