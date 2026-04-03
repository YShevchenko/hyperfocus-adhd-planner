import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Circular countdown timer widget — fills as time progresses.
class PieTimer extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final int remainingSeconds;
  final double size;
  final Color color;
  final Color backgroundColor;

  const PieTimer({
    super.key,
    required this.progress,
    required this.remainingSeconds,
    this.size = 120,
    this.color = AppColors.primary,
    this.backgroundColor = AppColors.surfaceLight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _PieTimerPainter(
              progress: progress,
              color: color,
              backgroundColor: backgroundColor,
            ),
          ),
          Text(
            _formatTime(remainingSeconds),
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: size * 0.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

class _PieTimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _PieTimerPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;

    // Background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PieTimerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
