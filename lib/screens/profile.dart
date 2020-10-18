import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoPlayer/screens/authenticate/AuthService.dart';
import 'package:videoPlayer/screens/authenticate/sign_in.dart';
import 'package:videoPlayer/screens/authenticate/user.dart';
import 'package:videoPlayer/screens/wrapper.dart';
import '../constants/themes.dart';
import 'dart:math';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: ThemeConstants.BGCOLOR_DARK,
          ),
        ),
        Positioned(
          height: size.height * 0.40,
          child: CustomPaint(
            size: size,
            painter: NiceBackground(),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await Provider.of<AuthService>(context, listen: false)
                .logoutCurrentUser();
            Navigator.pushReplacementNamed(context, '/sign');
          },
          child: Positioned(
            top: size.height * 0.18,
            right: 50,
            child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Provider.of<UserManage>(context, listen: false)
                            .user
                            .image !=
                        ''
                    ? Image.network(
                        Provider.of<UserManage>(context, listen: false)
                            .user
                            .image,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'assets/images/omkar.png',
                        fit: BoxFit.contain,
                      )),
          ),
        ),
        Positioned(
          top: size.height * 0.105,
          left: size.width * 0.049,
          child: Text(
            Provider.of<UserManage>(context, listen: false).user.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.70,
          height: size.height * 0.35,
          child: Transform.rotate(
            angle: pi,
            child: CustomPaint(
              size: size,
              painter: NiceBackground(),
            ),
          ),
        ),
      ],
    );
  }
}

// class MeraClipper extends CustomClipper<Path> {
//   @override
//   getClip(Size size) {
//     Rect design = Rect.fromCircle(center: Offset(50, 50), radius: 50);

//     Path customPath = Path()..addOval(design);
//     customPath.close();

//     return customPath;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) {
//     return true;
//   }
// }

class NiceBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var height = size.height;
    var width = size.width;

    var myPath = Path()
      ..lineTo(0, height / 2)
      ..quadraticBezierTo(
          width / 4, height / 4 + height / 2, width / 2, height / 2)
      ..quadraticBezierTo(width / 4 + width / 2, height / 4, width, height / 2)
      ..lineTo(width, 0)
      ..close();

    Rect rect = Rect.largest;

    var paintBrush = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.fill
      ..color = ThemeConstants.TEXT_CHAT_ACTIVE;

    canvas.drawPath(myPath, paintBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
