import 'dart:math';

import 'package:flutter/material.dart';

class FireworksPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random = Random();

  FireworksPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    for (int i = 0; i < 5; i++) {
      // Draw multiple crackers
      drawFirework(canvas, size, paint, i);
    }
  }

  void drawFirework(Canvas canvas, Size size, Paint paint, int index) {
    final double centerX = random.nextDouble() * size.width; // Random x position
    final double centerY = random.nextDouble() * size.height * 0.5; // Random y position (upper half)

    final double radius = animation.value * 100 + random.nextDouble() * 50;
    final double opacity = (1 - animation.value).clamp(0.0, 1.0);

    for (int i = 0; i < 15; i++) {
      final double angle = (2 * pi / 15) * i;
      final double offsetX = radius * cos(angle);
      final double offsetY = radius * sin(angle);

      paint.color = Colors.primaries[index % Colors.primaries.length].withOpacity(opacity);

      canvas.drawLine(Offset(centerX, centerY), Offset(centerX + offsetX, centerY + offsetY), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Continues to repaint as animation progresses.
  }
}