import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/core/utils/validators.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/app_logo.dart';
import 'package:tb_flutter/core/widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      func() =>
          context.read<UserRepository>().useRegisterMutation(email: email);
      return context.read<TanStackCubit>().mutation(func);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TanStackCubit, TanStackState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go(
            AppConstants.signUpVerificationRoute.replaceAll(
              ':email',
              _emailController.text,
            ),
          );
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Center(
                    child: Text(
                      'Register with your email',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: AppTextField(
                      hintText: 'Email address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                  ),
                  const SizedBox(height: 52),

                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.labelMedium,
                        children: [
                          TextSpan(text: 'By continuing, you agree to our\n'),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<TanStackCubit, TanStackState>(
                    builder: (_, state) {
                      return AppButton(
                        text: 'NEXT',
                        isLoading: state.isLoading,
                        onPressed: () => _handleSignUp(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // 导航到登录页（如果有的话）
            },
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  const TextSpan(text: 'Already have an account? '),
                  TextSpan(
                    text: 'Log In',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.go(AppConstants.loginRoute);
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
