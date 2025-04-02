import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/gradient_background.dart';

class RegistrationCompletePage extends StatelessWidget {
  const RegistrationCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    // 成功标志
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // 注册完成文本
                    const Text(
                      'Registration Complete!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 3),
                    // 开始按钮
                    AppButton(
                      text: 'Let\'s Go',
                      onPressed: () {
                        context.go(AppConstants.homeRoute);
                      },
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
