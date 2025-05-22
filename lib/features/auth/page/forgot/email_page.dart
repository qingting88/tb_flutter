import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/config/app_theme.dart';
import 'package:tb_flutter/core/http/http_model.dart';
import 'package:tb_flutter/core/model/secure.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import '../../../../../core/widgets/app_logo.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';

class ForgotEmailPage extends StatefulWidget {
  final String email;
  const ForgotEmailPage({super.key, required this.email});

  @override
  State<StatefulWidget> createState() {
    return _ForgotEmailPageState();
  }
}

class _ForgotEmailPageState extends State<ForgotEmailPage> {
  final _formKey = GlobalKey<FormState>();
  void _handleNext(BuildContext context, String code) async {
    if (_formKey.currentState!.validate()) {
      func() => context.read<UserRepository>().useForgotVerifyMutation(
        email: widget.email,
        code: code,
      );
      return context.read<TanStackCubit>().query(func);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TanStackCubit, TanStackState>(
      listener: (context, state) {
        if (state.isSuccess) {
          if (state.SuccessCode == SUCCESS_CODE.UPGRADE_TOKEN) {
            final secure = state.data?[0]['secure'];
            secure['secure_setting']['email_verify'] = false;
            context.go(
              AppConstants.twoFaRoute,
              extra: ISecure.fromJson(secure),
            );
          } else {
            context.go(AppConstants.forgotPasswordRoute);
          }
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
            child: Form(
              key: _formKey,
              onChanged: () => context.read<TanStackCubit>().reset(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      VerificationCodeInput(
                        title:
                            "The 6-digit code has been sent to ${widget.email}",
                        type: VerificationCodeType.email,
                        onPressed:
                            () => context
                                .read<UserRepository>()
                                .useSendEmailMutation(email: widget.email),
                        onCompleted: (code) => _handleNext(context, code),
                      ),
                    ],
                  ),
                  BlocSelector<TanStackCubit, TanStackState, String>(
                    selector: (state) {
                      return state.error?.message ?? '';
                    },
                    builder: (_, message) {
                      // return widget here based on the selected state.
                      if (message.isNotEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Center(
                            child: Text(
                              message,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: AppTheme.errorColor),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
