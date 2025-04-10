import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/widgets/gradient_background.dart';
import 'package:tb_flutter/core/widgets/toast.dart';
import 'package:tb_flutter/modules/http/task_result.dart';
import 'package:tb_flutter/modules/user/api/user.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _handleLoginNext(BuildContext context) async {
    TaskResult<dynamic> result = await UserApi.useLoginMutation(
      username: "username",
      password: "password",
    );
    if (result.success) {
      Toast.success(context, result.toString());
    } else {
      Toast.error(context, result.msg.toString());
    }
  }

  void _handleForgotPassword(BuildContext context) {
    context.go(AppConstants.forgotPasswordRoute);
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: GradientBackground(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  AppTextField(
                                    hintText: 'Email address',
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: Validators.validateEmail,
                                  ),
                                  const SizedBox(height: 10),
                                  AppTextField(
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
                                  const SizedBox(height: 10),
                                  Center(
                                    child: TextButton(
                                      onPressed:
                                          () => _handleForgotPassword(context),
                                      child: Text.rich(
                                        TextSpan(
                                          text: 'Forgot password?',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  AppButton(
                                    text: 'Next11',
                                    onPressed: () => _handleLoginNext(context),
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
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap =
                                              () => _handleSignup(context),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
