
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
/*
USER_REQUIRED?? and 1 second of null screen
*/

/*
Error list
-----------
119 - Wrong password
120 - User not found
*/

class AuthService with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  User currentUser;
  String errorText = "";

  //TODO: fix signout pulling back to verify page despite multiple checks
  //fixed the bug was that the "Stream was being rebuilt on each change."

  // void printWrapped(String text) {
  //   final pattern = new RegExp('.{1,400}'); // 800 is the size of each chunk
  //   pattern.allMatches(text).forEach((match) => print(match.group(0)));
  // }

  // static GetStorage userStorage = GetStorage("UserData");

  // static String currentUsername;

  // static postUserName(String username) async {
  //   Dio dio = new Dio()
  //     ..options =
  //         BaseOptions(baseUrl: "http://183.83.48.186", connectTimeout: 10000);
  //   try {
  //     String token = (await AuthService().getValidToken());
  //     Response response = await dio.post('/user/signup',
  //         options:
  //             Options(validateStatus: (_) => true, headers: {"token": token}),
  //         data: {"username": username});
  //     print("POSTUSERNAME $response");
  //     print("status ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       currentUsername = username;
  //       return true;
  //     } else if (response.statusCode == 409) {
  //       //conflict
  //       return false;
  //     }
  //     {
  //       return null;
  //     }
  //   } catch (e) {
  //     print("postusername $e");
  //     return null;
  //   }
  // }

  // static getUserDetails() async {
  //   Dio dio = new Dio()
  //     ..options =
  //         BaseOptions(baseUrl: "http://183.83.48.186", connectTimeout: 10000);
  //   try {
  //     String token = (await AuthService().getValidToken());
  //     Response r = await dio.get('/user',
  //         options:
  //             Options(validateStatus: (_) => true, headers: {"token": token}));
  //     dio.close();
  //     if (r.statusCode == 404) {
  //       //putUser
  //       return false;
  //     } else if (r.statusCode == 401) {
  //       throw {"error": r, "errorName": "401"};
  //     } else if (r.statusCode == 200) {
  //       currentUsername = r.data["username"];
  //       print("Response getuser $r");
  //       return r;
  //     } else {
  //       throw {"error": r, "errorName": "Unimplemented Exception"};
  //     }
  //   } on DioError catch (e) {
  //     print("get user details $e");
  //     dio.close();
  //     throw {"error": e, "errorName": "DioError"};
  //   }
  // }

  Future getIdToken() async {
    await _auth.currentUser()
      ..getIdToken(refresh: true).then((idToken) async {
        var verifyUrl =
            "https://2xsjhdvjcc.execute-api.ap-south-1.amazonaws.com/Prod/verifyId";
        // var verifyUrl = "http://192.168.169.177:3000/verifyId";
        var body = '{"OID":"${idToken.token}"}';
        var response = await http.post(verifyUrl, body: body);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      });
  }

  Future<String> getValidToken() async {
    FirebaseUser currentUser = await _auth.currentUser();
    await currentUser.reload();
    String token = "";
    await currentUser.getIdToken().then((idToken) async {
      print(
          "interceptor token generated for ${currentUser.displayName}${currentUser.uid}");
      token = idToken.token;
    }).catchError((err) {
      print("error no token interceptor");
      token = "";
    });
    return token;
  }

  Future<bool> isCurrentUserVerified() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) return false;
    await user.reload();
    print(user.toString());
    return user.isEmailVerified;
  }

  Future<bool> sendVerificationLink() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) return false;
    try {
      await user.sendEmailVerification();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void setSnackbarText(String text) {
    errorText = text;
    notifyListeners();
  }

  void toggleLoading(bool e) {
    isLoading = e;
    notifyListeners();
  }

  Future<String> get getUserEmail async {
    FirebaseUser user = await _auth.currentUser();
    return user.email;
  }

  void get getUser async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null)
      currentUser = User(
          uid: user.uid,
          isEmailVerified: user.isEmailVerified,
          email: user.email);
    notifyListeners();
  }

  Future<dynamic> signIn(String email, String password) async {
    email = email.trim();
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      print("" + user.toString());
      return user;
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("ERROR_WRONG_PASSWORD"))
        setSnackbarText("Invalid username/password combination");
      else if (e.toString().contains("ERROR_USER_NOT_FOUND"))
        setSnackbarText("User not found");
      else if (e.toString().contains("ERROR_INVALID_EMAIL"))
        setSnackbarText("Your email address is improperly formatted");
      else
        setSnackbarText("${e.toString()}");
      return null;
    }
  }

  Future<dynamic> register(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password))
          .user;
      print("" + user.toString());

      return _getUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE"))
        setSnackbarText("This email address is already in use");
      else if (e.toString().contains("ERROR_INVALID_EMAIL"))
        setSnackbarText("Your email address is improperly formatted");
      else
        setSnackbarText("${e.toString()}");
      return null;
    }
  }

  Future<bool> logoutCurrentUser() async {
    if ((await _auth.currentUser()) == null) return true;
    try {
      await _auth.signOut();
      print("Signed out user Successfully");
      currentUser = null;
      currentUsername = null;
      return true;
    } catch (e) {
      print(e.toString());
      print("Signout Unsuccessful");
      return false;
    }
  }

  User _getUserFromFirebaseUser(FirebaseUser user) {
    return (user != null)
        ? User(
            uid: user.uid,
            isEmailVerified: user.isEmailVerified,
            email: user.email)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_getUserFromFirebaseUser);
  }

  Future<FirebaseUser> registerWithGoogle() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    try {
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.toString());

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
