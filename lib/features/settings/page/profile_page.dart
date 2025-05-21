import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/config/app_theme.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/app_dialog.dart';
import 'package:tb_flutter/core/widgets/svgo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(),
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Icon(Icons.account_circle, size: 80.0),
          ),
          Text("Hi,", style: Theme.of(context).textTheme.displayLarge),
          Text(
            "johndoe@gmail.com",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.successColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline_outlined, color: Colors.white),
                Expanded(
                  child: Center(
                    child: Text(
                      "Your identity is verified.",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Divider(),
              GestureDetector(
                onTap: () {
                  context.go(AppConstants.settingsSecurityRoute);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    spacing: 8,
                    children: [
                      SvgIcons.padlock,
                      Text(
                        'Security settings',
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
                  context.go(AppConstants.settingsPasswordRoute);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    spacing: 8,
                    children: [
                      SvgIcons.passport,
                      Text(
                        'Change password',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SvgIcons.arrowBlackRight,
                    ],
                  ),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 6,
                children: [
                  TextButton.icon(
                    icon: SvgIcons.quit,
                    label: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.errorColor,
                      ),
                    ),
                    onPressed: () {
                      AppDialog.show(
                        content: 'Are you sure you want to Log out?',
                        btns: [
                          DialogButton(text: 'Stay', onClick: () {}),
                          DialogButton(
                            text: 'Logout',
                            buttonType: ButtonType.error,
                            onClick: () async{
                              // final a=await context
                              //     .read<UserRepository>()
                              //     .usePasswordUpgradeMutation(password: "");
                              //     return true
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
