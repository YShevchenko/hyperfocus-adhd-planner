import 'package:flutter/material.dart';

/// Calming, low-stimulation color palette for HyperFocus.
class AppColors {
  AppColors._();

  // Primary palette — dark, calming
  static const Color background = Color(0xFF1A1A2E); // dark navy
  static const Color surface = Color(0xFF0F3460); // deep blue
  static const Color surfaceLight = Color(0xFF16213E); // slightly lighter navy
  static const Color primary = Color(0xFFE94560); // coral
  static const Color primaryLight = Color(0xFFFF6B81);
  static const Color primaryDark = Color(0xFFC62A45);
  static const Color secondary = Color(0xFF16C79A); // mint
  static const Color secondaryLight = Color(0xFF4DDBAB);
  static const Color secondaryDark = Color(0xFF0E9E7A);
  static const Color accent = Color(0xFF53D8FB); // soft cyan

  // One Thing Mode
  static const Color oneThingBackground = Color(0xFF000000); // pure black
  static const Color oneThingText = Color(0xFFFFFFFF); // pure white
  static const Color oneThingDimText = Color(0xFF555555); // dim grey

  // Status colors
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color success = Color(0xFF16C79A);
  static const Color info = Color(0xFF53D8FB);

  // Text colors
  static const Color textPrimary = Color(0xFFEEEEEE);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textLight = Color(0xFF6B7280);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // Divider / border
  static const Color divider = Color(0xFF2A2A4A);
  static const Color border = Color(0xFF333355);

  // Card shadow
  static const Color shadow = Color(0x33000000);

  // Category colors
  static const Color cleaningColor = Color(0xFF53D8FB);
  static const Color selfCareColor = Color(0xFFFF6B81);
  static const Color adminColor = Color(0xFFFFA07A);
  static const Color workColor = Color(0xFF7C83FD);
  static const Color cookingColor = Color(0xFF16C79A);
  static const Color socialColor = Color(0xFFE9A0FF);
}
