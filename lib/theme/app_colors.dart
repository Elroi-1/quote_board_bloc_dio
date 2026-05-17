import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core background (Dark Theme)
  static const Color background = Color(0xFF0F172A); // Slate 900
  static const Color backgroundAlt = Color(0xFF1E293B); // Slate 800
  static const Color surface = Color(0xFF1E293B);
  static const Color surfaceDeep = Color(0xFF020617); // Slate 950

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color notReady = Color(0xFFF59E0B); // Amber 500

  // Custom Element Colors
  static const Color appBarText = Color(0xFFF8FAFC);
  static const Color servicesTitle = Color(0xFF38BDF8); // Sky 400
  static const Color pillToggleSelected = Color(0xFF3B82F6); // Blue 500
  static const Color pillToggleInactive = Color(0xFF64748B); // Slate 500
  static const Color navSurface = Color(0xFF1E293B);
  static const Color navBorder = Color(0xFF334155); // Slate 700
  static const Color navShadow = Color(0xFF0F172A);

  static final LinearGradient grad = LinearGradient(
    colors: [
      const Color(0xFF38BDF8).withValues(alpha: 0.1),
      const Color(0xFF38BDF8).withValues(alpha: 0.8),
      const Color(0xFF38BDF8).withValues(alpha: 0.1),
    ],
    stops: const [0.0, 0.5, 1.0],
  );
}
