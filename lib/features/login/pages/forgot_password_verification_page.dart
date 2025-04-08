import 'package:flutter/material.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/gradient_background.dart';
import 'package:tb_flutter/core/widgets/verification_code_input.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordVerificationPageState();
  }
}

class _ForgotPasswordVerificationPageState extends State<ForgotPasswordVerificationPage> {
  final _smsVerificationController = TextEditingController();
  final _authenticatorController = TextEditingController();
  final _scrollController = ScrollController(); // 添加滚动控制器
  bool _keyboardIsShow = false; // 键盘显示状态

  @override
  void dispose() {
    _smsVerificationController.dispose();
    _authenticatorController.dispose();
    _scrollController.dispose(); // 释放滚动控制器
    super.dispose();
  }

  void _handleVerification(BuildContext context, String smsCode, String authenticatorCode) {
    // TODO：跳转到安全验证页，使用 smsCode 和 authenticatorCode 进行验证
  }

  void _resendVerificationCode() {
    // 待实现
  }

  // 新增方法：滚动到页面底部
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _keyboardIsShow = false;
        },
        child: GradientBackground(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController, // 使用滚动控制器
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Security Verification',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '6-digit code has sent to\n+01 312****3233',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Verification code',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 30),
                                  VerificationCodeInput(
                                    length: 6,
                                    onCompleted: (code) {
                                      // Handle SMS verification code
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  TextButton(
                                    onPressed: _resendVerificationCode,
                                    child: const Text(
                                      'Resend verification code',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        decorationColor: Colors.blue,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    'The 6-digit code from Authenticator',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Authenticator code',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 30),
                                  VerificationCodeInput(
                                    length: 6,
                                    onCompleted: (code) {
                                      // Handle Authenticator verification code
                                    },
                                    onEditing: (isEditing) {
                                      if (isEditing && _keyboardIsShow == false) {
                                        _keyboardIsShow = true;
                                        _scrollToBottom();
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  ElevatedButton(
                                    onPressed: () {
                                      final smsCode = _smsVerificationController.text;
                                      final authenticatorCode = _authenticatorController.text;
                                      _handleVerification(context, smsCode, authenticatorCode);
                                    },
                                    child: const Text('Verify'),
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