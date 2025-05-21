import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';
import 'package:tb_flutter/features/settings/widget/stepper.dart';

class GoogleStep4Page extends StatelessWidget {
  const GoogleStep4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Google Authenticator Enable',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300),
                      child: Text(
                        'Enable the Authenticator by verifying your account',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 40),
                  child: HorizontalStepper(
                    currentStep: 3, // 当前步骤（从1开始）
                    totalSteps: 4, // 总步骤数
                  ),
                ),
                VerificationCodeInput(
                  title: "Enter the 6-digit code from Authenticator",
                  type: VerificationCodeType.google,
                  onCompleted:
                      (code) => {
                        context.go(AppConstants.settingsSecurityRoute),
                      },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
