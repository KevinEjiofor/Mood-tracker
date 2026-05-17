import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodFacePainter extends CustomPainter {
  final MoodType mood;
  final Color color;
  final double animationValue;

  MoodFacePainter({required this.mood, required this.color, this.animationValue = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r  = (size.width * 0.42) * animationValue;

    final facePaint = Paint()..color = color..style = PaintingStyle.fill;
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    final outlinePaint = Paint()
      ..color = Colors.black.withOpacity(0.12)
      ..style = PaintingStyle.stroke..strokeWidth = 2;
    final featurePaint = Paint()
      ..color = const Color(0xFF2D2D2D)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.045;
    final eyePaint = Paint()
      ..color = const Color(0xFF2D2D2D)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cx + 3, cy + 4), r, shadowPaint);
    canvas.drawCircle(Offset(cx, cy), r, facePaint);
    canvas.drawCircle(Offset(cx, cy), r, outlinePaint);

    final eyeY = cy - r * 0.18;
    final eyeX = r * 0.30;
    final eyeR = r * 0.09;

    switch (mood) {
      case MoodType.happy:
        _fillEyes(canvas, cx, eyeY, eyeX, eyeR, eyePaint);
        canvas.drawArc(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.12), width: r * 1.0, height: r * 0.55),
          0.18, 2.75, false, featurePaint);
        _cheeks(canvas, cx, cy, r);
        break;
      case MoodType.excited:
        _fillEyes(canvas, cx, eyeY, eyeX, eyeR * 1.5, eyePaint);
        final hi = Paint()..color = Colors.white..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(cx - eyeX + eyeR * 0.5, eyeY - eyeR * 0.5), eyeR * 0.45, hi);
        canvas.drawCircle(Offset(cx + eyeX + eyeR * 0.5, eyeY - eyeR * 0.5), eyeR * 0.45, hi);
        canvas.drawOval(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.35), width: r * 0.38, height: r * 0.28),
          Paint()..color = const Color(0xFF2D2D2D)..style = PaintingStyle.fill);
        _cheeks(canvas, cx, cy, r);
        break;
      case MoodType.neutral:
        _fillEyes(canvas, cx, eyeY, eyeX, eyeR, eyePaint);
        canvas.drawLine(
          Offset(cx - r * 0.28, cy + r * 0.28),
          Offset(cx + r * 0.28, cy + r * 0.28),
          featurePaint);
        break;
      case MoodType.tired:
        final halfEye = Paint()..color = const Color(0xFF2D2D2D)..style = PaintingStyle.fill;
        for (final s in [-1.0, 1.0]) {
          final er = Rect.fromCenter(
            center: Offset(cx + s * eyeX, eyeY), width: eyeR * 2.8, height: eyeR * 2.0);
          canvas.drawArc(er, 3.14, 3.14, true, halfEye);
          canvas.drawArc(er, 3.14, 3.14, false,
            featurePaint..strokeWidth = size.width * 0.03);
        }
        featurePaint.strokeWidth = size.width * 0.045;
        canvas.drawArc(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.38), width: r * 0.65, height: r * 0.28),
          3.44, 2.56, false, featurePaint);
        break;
      case MoodType.sad:
        _fillEyes(canvas, cx, eyeY, eyeX, eyeR, eyePaint);
        canvas.drawLine(
          Offset(cx - eyeX - r * 0.18, eyeY - r * 0.28),
          Offset(cx - eyeX + r * 0.1,  eyeY - r * 0.40), featurePaint);
        canvas.drawLine(
          Offset(cx + eyeX - r * 0.1,  eyeY - r * 0.40),
          Offset(cx + eyeX + r * 0.18, eyeY - r * 0.28), featurePaint);
        canvas.drawArc(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.52), width: r * 0.85, height: r * 0.45),
          3.44, 2.56, false, featurePaint);
        _tear(canvas, cx + eyeX + r * 0.05, eyeY + eyeR, r * 0.08);
        break;
    }
  }

  void _fillEyes(Canvas c, double cx, double ey, double ex, double er, Paint p) {
    c.drawCircle(Offset(cx - ex, ey), er, p);
    c.drawCircle(Offset(cx + ex, ey), er, p);
  }

  void _cheeks(Canvas c, double cx, double cy, double r) {
    final p = Paint()..color = Colors.pink.withOpacity(0.22)..style = PaintingStyle.fill;
    c.drawCircle(Offset(cx - r * 0.44, cy + r * 0.22), r * 0.18, p);
    c.drawCircle(Offset(cx + r * 0.44, cy + r * 0.22), r * 0.18, p);
  }

  void _tear(Canvas c, double x, double y, double s) {
    final path = Path()
      ..moveTo(x, y)
      ..cubicTo(x + s, y + s, x + s, y + s * 2.5, x, y + s * 3)
      ..cubicTo(x - s, y + s * 2.5, x - s, y + s, x, y)
      ..close();
    c.drawPath(path, Paint()..color = const Color(0xFF4D96FF)..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(MoodFacePainter old) =>
      old.mood != mood || old.animationValue != animationValue;
}
