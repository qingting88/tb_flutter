import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/svgo.dart';
import 'package:tb_flutter/features/settings/widget/stepper.dart';

class GoogleStep1Page extends StatelessWidget {
  const GoogleStep1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'Download and install the authenticator App.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 40),
                child: HorizontalStepper(
                  currentStep: 1, // 当前步骤（从1开始）
                  totalSteps: 4, // 总步骤数
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 16, top: 8),
                              child: SvgIcons.ios,
                            ),
                            Text(
                              'iOS',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Download from',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'App Store',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[600]),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 16, top: 8),
                                child: SvgIcons.android,
                              ),
                              Text(
                                'Android',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Download from',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Google Play',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppButton(text: "INSTALLED, NEXT", onPressed: () => {
            context.go(AppConstants.settingsGoogleStep2Route)
          }),
        ],
      ),
    );
  }
}
