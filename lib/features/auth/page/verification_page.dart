import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_logo.dart';
import 'package:tb_flutter/core/widgets/gradient_background.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  void _handleVerification(BuildContext context, String code) {
    // 保存验证码到状态
    // final authState = Provider.of<AuthState>(context, listen: false);
    // authState.setVerificationCode(code);

    // 导航到密码设置页面
    context.go(AppConstants.passwordSetupRoute);
  }

  void _resendVerificationCode() {
    // 实际应用中，这里会调用重新发送验证码的API
  }

  @override
  Widget build(BuildContext context) {
    // final authState = Provider.of<AuthState>(context);
    // final email = authState.email ?? '';
    final email ='asda';

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Check Your Email',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'We sent verification code to $email',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 40),
                              VerificationCodeInput(
                                length: 4,
                                onCompleted:
                                    (code) =>
                                        _handleVerification(context, code),
                              ),
                              const SizedBox(height: 30),
                              TextButton(
                                onPressed: _resendVerificationCode,
                                child: const Text(
                                  'Resend verification code',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
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
