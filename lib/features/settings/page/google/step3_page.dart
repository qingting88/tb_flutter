import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/svgo.dart';
import 'package:tb_flutter/features/settings/widget/stepper.dart';

class GoogleStep3Page extends StatelessWidget {
  const GoogleStep3Page({super.key});

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
                    child: Text(
                      'Scan the QR code in the Authenticator app.',
                      style: Theme.of(context).textTheme.bodyMedium,
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
                Center(child: SizedBox(width: 100,height: 124, child: SvgIcons.passport)),
                SizedBox(height: 16),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'FEFESU4235BHUYBD',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Color(0xb30b042b),
                        ),
                      ),
                      SvgIcons.copy,
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'This Key will allow you to recover your Authenticator should you lose your phone.',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            AppButton(
              text: "NEXT",
              onPressed: () {
                context.go(AppConstants.settingsGoogleStep4Route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
