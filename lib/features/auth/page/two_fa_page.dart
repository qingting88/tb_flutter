import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/model/secure.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/app_logo.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';

class AuthTwoFaPage extends StatefulWidget {
  final ISecure secure;
  const AuthTwoFaPage({super.key, required this.secure});

  @override
  AuthTwoFaPageState createState() => AuthTwoFaPageState();
}

class AuthTwoFaPageState extends State<AuthTwoFaPage> {
  String email_code = '';
  String phone_code = '';
  String ga_code = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TanStackCubit, TanStackState>(
      listener: (context, state) {
        // do stuff here based on BlocA's state
        if (state.isSuccess) {
          context.go(AppConstants.forgotPasswordRoute);
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Center(child: AppLogo(size: 50)),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.only(
              top: 36,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Forgot Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  spacing: 32,
                  children: [
                    if (widget.secure.secure_setting.email_verify)
                      VerificationCodeInput(
                        title:
                            "The 6-digit code has been sent to ${widget.secure.user_email}",
                        type: VerificationCodeType.email,
                        onPressed:
                            () => context
                                .read<UserRepository>()
                                .useSendEmailMutation(email: 'aaa@qq.com'),
                        onCompleted:
                            (code) => {
                              setState(() {
                                email_code = code;
                              }),
                            },
                      ),
                    if (widget.secure.secure_setting.phone_verify)
                      VerificationCodeInput(
                        title:
                            "6-digit code has sent to ${widget.secure.phone_country_code} ${widget.secure.phone_number}",
                        type: VerificationCodeType.phone,
                        onPressed:
                            () =>
                                context
                                    .read<UserRepository>()
                                    .useSendPhoneMutation(),
                        onCompleted:
                            (code) => {
                              setState(() {
                                phone_code = code;
                              }),
                            },
                      ),
                    if (widget.secure.secure_setting.two_factor)
                      VerificationCodeInput(
                        title: "Enter the 6-digit code from Authenticator",
                        type: VerificationCodeType.google,
                        onCompleted:
                            (code) => {
                              setState(() {
                                ga_code = code;
                              }),
                            },
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: "NEXT",
                  onPressed: () async {
                    func() =>
                        context.read<UserRepository>().use2faVerifyMutation(
                          I2FaVerify(
                            secure_verify: ISecureVerify(
                              email_code: email_code,
                              phone_code: phone_code,
                              ga_code: ga_code,
                            ),
                          ),
                        );
                    return context.read<TanStackCubit>().query(func);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
