import 'package:flutter/material.dart';
import '../constants/themes.dart';
// import 'dart:math';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        width: size.width,
        decoration: BoxDecoration(
          color: ThemeConstants.BGCOLOR_DARK,
        ),
      ),
      Positioned(
        height: size.height * 0.35,
        child: CustomPaint(
          size: size,
          painter: NiceBackground(),
        ),
      ),
      Positioned(
        top: size.height * 0.18,
        right: 0,
        child: Container(
            margin: EdgeInsets.all(10),
            height: size.height * 0.2,
            width: size.height * 0.2,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.asset(
                './assets/images/omkar.png',
                fit: BoxFit.cover,
              ),
            )),
      )
    ]);
  }
}

// class MeraClipper extends CustomClipper<Path> {
//   @override
//   getClip(Size size) {
//     Rect design =
//         Rect.fromCircle(center: Offset(size.width, size.height), radius: 40);

//     Path customPath = Path()..addArc(design, 0, 2 * pi);

//     return customPath;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) {
//     return false;
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
