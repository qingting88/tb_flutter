import 'package:flutter/material.dart';

class AppTheme {
  // 颜色
  static const Color primaryColor = Color(0xFFFF1493); // 亮粉色
  static const Color secondaryColor = Color(0xFF5D5FEF); // 蓝紫色
  static const Color gradientStartColor = Color(0xFFFF1493); // 粉色渐变起点
  static const Color gradientEndColor = Color(0xFF5D5FEF); // 蓝紫色渐变终点
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF1F2937); // 深灰色文本
  static const Color disabledColor = Color(0xFFE5E7EB); // 禁用状态颜色

  // 主题数据
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'SF Pro Display',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textColor),
        bodyMedium: TextStyle(fontSize: 14, color: textColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.grey[400]),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  // 渐变背景
  static BoxDecoration gradientBackground = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [gradientStartColor, gradientEndColor],
    ),
  );
}
