import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool extendBody;

  const GradientBackground({
    Key? key,
    required this.child,
    this.extendBody = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 设置状态栏为透明
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppTheme.gradientBackground,
      child: SafeArea(
        bottom: !extendBody,
        maintainBottomViewPadding: true,
        child: child,
      ),
    );
  }
}
