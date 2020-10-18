import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoPlayer/constants/themes.dart';
import 'package:videoPlayer/screens/authenticate/AuthService.dart';
import 'package:videoPlayer/screens/authenticate/user.dart';
import 'package:videoPlayer/screens/authenticate/verify.dart';

import '../home.dart';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String username = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return ChangeNotifierProvider(
        create: (context) => _auth,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Scaffold(
                backgroundColor: ThemeConstants.BGCOLOR_DARK,
                body: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(76, 70, 76, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Form(
                                key: _formkey,
                                child: Column(children: [
                                  Text("Student Life",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      )),
                                  SizedBox(height: 20),
                                  Card(
                                    color: ThemeConstants.BGCOLOR_DARK_COMP,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "username"),
                                        onChanged: (val) {
                                          setState(() {
                                            this.username = val;
                                          });
                                        },
                                        validator: (val) {
                                          return (val.isEmpty)
                                              ? "Please provide a username"
                                              : null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: ThemeConstants.BGCOLOR_DARK_COMP,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration:
                                            InputDecoration(hintText: "email"),
                                        onChanged: (val) {
                                          setState(() {
                                            this.email = val;
                                          });
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) {
                                          return (val.isEmpty)
                                              ? "Please provide a valid email"
                                              : null;
                                        },
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 20),
                                  Card(
                                    color: ThemeConstants.BGCOLOR_DARK_COMP,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "password"),
                                        obscureText: true,
                                        validator: (val) {
                                          return (val.length < 6)
                                              ? "Password should be > 6 characters"
                                              : null;
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            this.password = val;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ])),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Builder(builder: (context) {
                                  AuthService _auth =
                                      Provider.of<AuthService>(context);
                                  return RaisedButton(
                                    onPressed: () async {
                                      //sign in
                                      print(this.email + " " + this.password);
                                      if (_formkey.currentState.validate()) {
                                        _auth.toggleLoading(true);
                                        dynamic user = await _auth.register(
                                            email, password);
                                        if (user != null && !(user is int)) {
                                          _auth.toggleLoading(false);
                                          print("" + user.toString());

                                          // Provider.of<AuthService>(context,listen: false).sendVerificationLink()
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerifyEmail(user, username,
                                                        password, email)),
                                          );
                                        } else {
                                          _auth.toggleLoading(false);
                                          final snackBar = SnackBar(
                                            content: Text(
                                                "Error: ${_auth.errorText}"),
                                          );
                                          Scaffold.of(context)
                                              .showSnackBar(snackBar);
                                          print("Registration failed");
                                        }
                                      } else {
                                        print("Error form is problematic");
                                      }
                                    },
                                    textColor: Colors.white,
                                    color: Colors.redAccent,
                                    child: Text("Register"),
                                  );
                                }),
                                SizedBox(width: 20),
                                Builder(
                                  builder: (BuildContext context) {
                                    return RaisedButton(
                                      onPressed: () async {
                                        //sign in
                                        print(this.email + " " + this.password);
                                        if (_formkey.currentState.validate()) {
                                          _auth.toggleLoading(true);
                                          dynamic user = await _auth.signIn(
                                              email, password);
                                          if (user != null && !(user is int)) {
                                            // print("" + user.toString());
                                            Provider.of<UserManage>(context,
                                                    listen: false)
                                                .getUser(
                                                    user: user,
                                                    username: username,
                                                    google: false);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()));
                                          } else {
                                            _auth.toggleLoading(false);
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  "Error: ${_auth.errorText}"),
                                            );
                                            Scaffold.of(context)
                                                .showSnackBar(snackBar);
                                            print("Registration failed");
                                          }
                                        } else {
                                          print("Error form is problematic");
                                        }
                                      },
                                      textColor: Colors.white,
                                      color: Colors.amberAccent,
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              onPressed: () async {
                                //sign in
                                _auth.toggleLoading(true);
                                try {
                                  var result = await _auth.registerWithGoogle();
                                  if (result == null)
                                    _auth.toggleLoading(false);
                                  print("Signed In With");

                                  print(result.displayName);
                                  Provider.of<UserManage>(context,
                                          listen: false)
                                      .getUser(user: result, google: true);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                } catch (err) {
                                  print(err);
                                }
                              },
                              color: Colors.white,
                              child: Text("Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            _auth.isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ));
  }
}
