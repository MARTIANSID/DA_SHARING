import 'package:flutter/material.dart';
import '../constants/themes.dart';

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
        height: size.height*0.5,
        child: CustomPaint(
          size: size,
          painter: NiceBackground(),
        ),
      ),
    ]);
  }
}

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
      ..color = Color(0xff226DC6)
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    canvas.drawPath(myPath, paintBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
