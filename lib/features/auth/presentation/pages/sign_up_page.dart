import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/utils/validators.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/app_logo.dart';
import 'package:tb_flutter/core/widgets/app_text_field.dart';
import 'package:tb_flutter/core/widgets/gradient_background.dart';
import 'package:tb_flutter/features/auth/domain/entities/auth_state.dart';

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

  void _handleSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // 保存邮箱到状态
      final authState = Provider.of<AuthState>(context, listen: false);
      authState.setEmail(_emailController.text);

      // 导航到验证码页面
      context.go(AppConstants.verificationRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      MediaQuery.of(context).padding.bottom + 20,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const Center(child: AppLogo(size: 50)),
                        const SizedBox(height: 60),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Register with your email',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 30),
                                AppTextField(
                                  hintText: 'Email address',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: Validators.validateEmail,
                                ),
                                const SizedBox(height: 30),
                                AppButton(
                                  text: 'Next',
                                  onPressed: () => _handleSignUp(context),
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
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go(AppConstants.loginRoute);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'By continuing, you agree to our ',
                              ),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
