import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_theme.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/core/bloc/auth_cubit.dart';

import '../../../core/config/app_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _handleLoginNext(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final username = _emailController.text;
      final password = _passwordController.text;
      func() => context.read<UserRepository>().useLoginMutation(
        username: username,
        password: password,
      );
      return context.read<TanStackCubit>().query(func);
    }
  }

  void _handleForgotPassword(BuildContext context) {
    context.push(AppConstants.forgotRoute);
  }

  void _handleSignup(BuildContext context) {
    context.go(AppConstants.signUpRoute);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>();
    return BlocListener<TanStackCubit, TanStackState>(
      listener: (context, state) {
        // do stuff here based on BlocA's state
        if (state.isSuccess) {
          auth.authCheckRequested();
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
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge,
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: AppTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: Validators.validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
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
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () => _handleForgotPassword(context),
                      child: Text.rich(
                        TextSpan(
                          text: 'Forgot password?',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<TanStackCubit, TanStackState>(
                    builder: (_, state) {
                      return AppButton(
                        text: 'NEXT',
                        isLoading: state.isLoading,
                        onPressed: () => _handleLoginNext(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Doesn't have an account yet? ",
                style: const TextStyle(color: Colors.white, fontSize: 12),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () => _handleSignup(context),
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
