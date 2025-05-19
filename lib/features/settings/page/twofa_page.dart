import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/features/settings/repository/user_repository.dart';
import 'package:tb_flutter/features/settings/widget/security_verification.dart';

class TwofaPage extends StatefulWidget {
  const TwofaPage({Key? key}) : super(key: key);

  @override
  _TwofaPage createState() => _TwofaPage();
}

class _TwofaPage extends State<TwofaPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Security Verifcation',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Column(
                spacing: 32,
                children: [
                  SecurityVerification(
                    title:
                        "The 6-digit code has been sent to j*****e@gmail.com",
                    type: SecurityVerificationType.sms,
                    onPressed:
                        () => context
                            .read<UserRepository>()
                            .useSendEmailMutation(email: 'aaa@qq.com'),
                    onCompleted: (code) => {},
                  ),
                  SecurityVerification(
                    title: "6-digit code has sent to +01 312***3233",
                    type: SecurityVerificationType.phone,
                    onPressed:
                        () =>
                            context
                                .read<UserRepository>()
                                .useSendPhoneMutation(),
                    onCompleted: (code) => {},
                  ),
                  SecurityVerification(
                    title: "Enter the 6-digit code from Authenticator",
                    type: SecurityVerificationType.google,
                    onCompleted: (code) => {},
                  ),
                ],
              ),
            ],
          ),
          AppButton(
            text: "NEXT",
            onPressed: () {
              context.go(AppConstants.settingsGoogleStep3Route);
            },
          ),
        ],
      ),
    );
  }
}
