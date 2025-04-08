import 'package:flutter/material.dart';
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
