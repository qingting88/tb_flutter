import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';

class SecondaryLayout extends StatelessWidget {
  final Widget child;
  final bool showBackButton;

  const SecondaryLayout({
    super.key,
    required this.child,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:
            showBackButton
                ? IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () => _handleBack(context),
                )
                : null,
      ),
      body: child,
    );
  }

  void _handleBack(BuildContext context) {
    // 智能返回逻辑
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppConstants.homeRoute);
    }
  }
}
