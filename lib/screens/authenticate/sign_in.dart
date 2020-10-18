import 'package:flutter/material.dart';
import 'package:videoPlayer/services/auth.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in !'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          onPressed: () async {
            dynamic result = await _authService.signInAnon(); //return the user

            if (result == null) {
              print('error sign ing');
            } else {
              print('Signed in ');
              print(result);
            }
          },
          child: Text('Sign in Anon '),
        ),
      ),
    );
  }
}
