import 'package:flutter/material.dart';
import '../../globalSettings.dart';

class CurvedBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: new Container(),
      painter: CustomCurve(),
    );
  }
}

class CustomCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    Paint paint = new Paint();
    paint.color = MAINHEADTEXTCOLOR.withOpacity(0.9);
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 1.2, size.width, 0);

    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
