import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/widgets/svgo.dart';

class SecuritySettingsPage extends StatelessWidget {
  const SecuritySettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Security Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              'Two-Factor Authentication (2FA)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 48),
            child: Text(
              'To protect your account, it is recommended to tun on at least one 2FA',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.go(AppConstants.settingsGoogleStep1Route);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                spacing: 8,
                children: [
                  SvgIcons.google,
                  Text(
                    'Google Autentication',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SvgIcons.arrowBlackRight,
                ],
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              // context.go(AppConstants.settingsSecurityRoute);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                spacing: 8,
                children: [
                  SvgIcons.email,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            'Email',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SvgIcons.arrowBlackRight,
                        ],
                      ),
                      Text(
                        'fri***ang@gmail.com',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              // context.go(AppConstants.settingsSecurityRoute);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgIcons.smartphone,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            'SMS',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SvgIcons.arrowBlackRight,
                        ],
                      ),
                      Text(
                        '+01 312***2223',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
