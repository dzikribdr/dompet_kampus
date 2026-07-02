import 'package:flutter/material.dart';

class AppColors {
  // Primary Blue
  static const Color primary = Color(0xFF0052CC);
  static const Color primaryLight = Color(0xFF3385FF);
  static const Color primaryDark = Color(0xFF003A99);
  static const Color primarySurface = Color(0xFFE6F0FF);
  static const Color primaryBorder = Color(0xFF99C2FF);
  // Secondary
  static const Color secondary = Color(0xFF6C757D);
  static const Color secondaryLight = Color(0xFF8A93A2);
  static const Color secondaryDark = Color(0xFF495057);
  static const Color secondarySurface = Color(0xFFF1F3F5);
  static const Color secondaryBorder = Color(0xFFCED4DA);

  // Semantic
  static const Color green = Color(0xFF28A745);
  static const Color greenSurface = Color(0xFFE8F8F2);
  static const Color amber = Color(0xFFFFA500);
  static const Color amberSurface = Color(0xFFFDF3E3);
  static const Color red = Color(0xFFDC3545);
  static const Color redSurface = Color(0xFFFDECED);
  static const Color violet = Color(0xFF6F42C1);
  static const Color violetSurface = Color(0xFFF0EEFF);

  // Neutral
  static const Color ink = Color(0xFF0E1726);
  static const Color slate600 = Color(0xFF4B5E78);
  static const Color slate500 = Color(0xFF6B7A90);
  static const Color slate400 = Color(0xFF9DABBE);
  static const Color slate300 = Color(0xFFCBD2DD);
  static const Color active = Color(0xFF0D6EFD);
  static const Color disabled = Color(0xFFADB5BD);
  static const Color buttonHover = Color(0xFF004099);
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFA500);
  static const Color line = Color(0xFFE8ECF2);
  static const Color line2 = Color(0xFFF3F5F8);
  static const Color bg = Color(0xFFF5F6FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF6C757D);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.55, 1.0],
    colors: [primaryLight, primary, primaryDark],
  );

  // Shadows
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];
  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 12,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];
  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: Color(0x520B63E5),
      blurRadius: 22,
      spreadRadius: 0,
      offset: Offset(0, 10),
    ),
  ];

  // Tone map for FeatureIcon
  static Map<String, List<Color>> tones = {
    'blue': [primarySurface, primary],
    'green': [greenSurface, green],
    'amber': [amberSurface, amber],
    'red': [redSurface, red],
    'violet': [violetSurface, violet],
    'slate': [bg, slate600],
  };

  static List<Color> tone(String name) => tones[name] ?? tones['blue']!;
}
