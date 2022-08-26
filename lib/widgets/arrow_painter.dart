import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';

class ArrowPainter extends CustomPainter {
  final bool dark;

  ArrowPainter({this.dark = true});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = dark ? purple900 : white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 1.0;

    Path path = Path();
    path.moveTo(size.width * 0.1, size.height / 2);
    path.lineTo(size.width * 0.9, size.height / 2);
    path = ArrowPath.make(path: path);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => false;
}
