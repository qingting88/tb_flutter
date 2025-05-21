import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';

class TwoFaPage extends StatefulWidget {
  const TwoFaPage({super.key});

  @override
  TwoFaPageState createState() => TwoFaPageState();
}

class TwoFaPageState extends State<TwoFaPage> {
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
                  VerificationCodeInput(
                    title:
                        "The 6-digit code has been sent to j*****e@gmail.com",
                    type: VerificationCodeType.email,
                    onPressed:
                        () => context
                            .read<UserRepository>()
                            .useSendEmailMutation(email: 'aaa@qq.com'),
                    onCompleted: (code) => {},
                  ),
                  VerificationCodeInput(
                    title: "6-digit code has sent to +01 312***3233",
                    type: VerificationCodeType.phone,
                    onPressed:
                        () =>
                            context
                                .read<UserRepository>()
                                .useSendPhoneMutation(),
                    onCompleted: (code) => {},
                  ),
                  VerificationCodeInput(
                    title: "Enter the 6-digit code from Authenticator",
                    type: VerificationCodeType.google,
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
