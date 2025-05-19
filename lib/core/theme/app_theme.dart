import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 颜色
  // static const Color primaryColor = Color(0xFFFF1493); // 亮粉色
  // static const Color secondaryColor = Color(0xFF5D5FEF); // 蓝紫色
  // static const Color gradientStartColor = Color(0xFFFF1493); // 粉色渐变起点
  // static const Color gradientEndColor = Color(0xFF5D5FEF); // 蓝紫色渐变终点
  // static const Color backgroundColor = Colors.white;
  // static const Color textColor = Color(0xFF1F2937); // 深灰色文本
  // static const Color disabledColor = Color(0xFFE5E7EB); // 禁用状态颜色

  static const Color primaryColor = Color(0xFF5D5FEF);
  static const Color secondaryColor = Color(0xFF242141);
  static const Color accentColor = Color(0xFFFF1493);
  static const Color neutralColor = Color(0xFF0b042b);
  static const Color infoColor = Color(0x0b042b65);
  static const Color successColor = Color(0xFF2cb103);
  static const Color warningColor = Color(0xFFF7931A);
  static const Color errorColor = Color(0xFFfb0772);

  static const Color textColor = Color(0xFF242141); // 标题颜色
  static const Color labelColor = Color(0x660b042b); // 文本颜色 #0b042b66

  // 主题数据 https://m3-theme.zeir.cc/dynamic/palette
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'SF Pro Display',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.golosTextTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          displaySmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),

          headlineLarge: TextStyle(
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),

          titleLarge: TextStyle(
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),

          bodyLarge: TextStyle(fontSize: 20, color: textColor),
          bodyMedium: TextStyle(fontSize: 16, color: textColor),
          bodySmall: TextStyle(fontSize: 12, color: textColor),

          labelLarge: TextStyle(fontSize: 20, color: labelColor),
          labelMedium: TextStyle(fontSize: 16, color: labelColor),
          labelSmall: TextStyle(fontSize: 12, color: labelColor),
        ),
      ),
      dividerTheme: DividerThemeData(
        space: 48,
        thickness: 2,
        endIndent: 0,
        color: Color(0x1aafafaf),
      ),

      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: primaryColor,
      //     foregroundColor: Colors.white,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //     minimumSize: const Size(double.infinity, 50),
      //   ),
      // ),
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
      colors: [accentColor, primaryColor],
    ),
  );
}
