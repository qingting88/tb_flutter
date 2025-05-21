import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/core/widgets/app_logo.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';

class SignUpVerificationPage extends StatelessWidget {
  final String email;
  const SignUpVerificationPage({super.key, required this.email});

  void _handleVerification(BuildContext context, String code) async {
    func() => context.read<UserRepository>().useRegisterVerifyMutation(
      email: email,
      code: code,
    );
    return context.read<TanStackCubit>().mutation(func);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TanStackCubit, TanStackState>(
      listener: (context, state) {
        // do stuff here based on BlocA's state
        if (state.isSuccess) {
          context.go(AppConstants.signUpPasswordRoute);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Check Your Email',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'We sent verification code to $email',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                VerificationCodeInput(
                  type: VerificationCodeType.email,
                  onPressed:
                      () => context.read<UserRepository>().useSendEmailMutation(
                        email: email,
                      ),
                  onCompleted: (code) => _handleVerification(context, code),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
