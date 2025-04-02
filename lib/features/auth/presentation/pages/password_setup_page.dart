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

class PasswordSetupPage extends StatefulWidget {
  const PasswordSetupPage({super.key});

  @override
  State<PasswordSetupPage> createState() => _PasswordSetupPageState();
}

class _PasswordSetupPageState extends State<PasswordSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handlePasswordSetup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // 保存密码到状态
      final authState = Provider.of<AuthState>(context, listen: false);
      authState.setPassword(_passwordController.text);

      // 标记注册完成
      authState.completeRegistration();

      // 导航到注册完成页面
      context.go(AppConstants.registrationCompleteRoute);
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
                                  'Set Your Password',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                AppTextField(
                                  hintText: 'Enter password',
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
                                const SizedBox(height: 30),
                                AppButton(
                                  text: 'Next',
                                  onPressed:
                                      () => _handlePasswordSetup(context),
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
    );
  }
}
