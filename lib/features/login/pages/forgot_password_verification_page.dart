import 'package:flutter/material.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/gradient_background.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return  _ForgotPasswordVerificationPageState();
  }
}

class _ForgotPasswordVerificationPageState extends State<ForgotPasswordVerificationPage> {
  final _verificationController = TextEditingController();

  void _handleVerification(BuildContext context, String code) {
    // TODO：跳转到安全验证页
  }

  void _resendVerificationCode() {
    // 待实现
  }

  @override
  void dispose() {
    _verificationController.dispose();
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
                    child: Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          const Center(child: AppLogo(size: 50)),
                          const SizedBox(height: 60),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(child: Text('Forgot Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
                                  const SizedBox(height: 10),
                                  const Center(
                                      child: Text('The 6-digit code has been sent to j*****e@gmail.com',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      )
                                  ),
                                  const SizedBox(height: 10),
                                  const Center(
                                      child: Text('Verification code',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      )
                                  ),
                                  const SizedBox(height: 30),
                                  VerificationCodeInput(
                                    length: 6,
                                    onCompleted:
                                        (code) =>
                                        _handleVerification(context, code),
                                  ),
                                  const SizedBox(height: 30),
                                  Center(
                                    child: TextButton(
                                      onPressed: _resendVerificationCode,
                                      child: const Text(
                                        'Resend verification code',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue,
                                          decorationColor: Colors.blue
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
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
