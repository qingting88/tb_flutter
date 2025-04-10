import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
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
  String? _smsErrorText; // 用于存储短信验证码错误提示
  String? _authenticatorErrorText; // 用于存储 Authenticator 验证码错误提示

  void _handleVerification(BuildContext context, String smsCode, String authenticatorCode) {
    // 模拟验证逻辑
    bool smsValid = smsCode == '123456'; // 假设正确的短信验证码是 123456
    bool authenticatorValid = authenticatorCode == '654321'; // 假设正确的 Authenticator 验证码是 654321

    // 更新错误提示
    setState(() {
      _smsErrorText = smsValid ? null : 'The verification code was incorrect';
      _authenticatorErrorText = authenticatorValid ? null : 'The Authenticator code was incorrect';
    });

    // 如果验证通过，跳转到设置密码页面
    if (smsValid && authenticatorValid) {
      context.push(AppConstants.passwordSetupRoute);
    }
  }

  void _resendVerificationCode() {
    // TODO： 实现重新发送验证码逻辑
  }

  // 滚动到页面底部
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
  void dispose() {
    _smsVerificationController.dispose();
    _authenticatorController.dispose();
    _scrollController.dispose(); // 释放滚动控制器
    super.dispose();
  }

  Widget _buildVerificationCodeInput(TextEditingController controller, String label, {String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        VerificationCodeInput(
          length: 6,
          onCompleted: (code) {
            // 处理验证码输入完成逻辑
            if (controller == _smsVerificationController) {
              _smsVerificationController.text = code;
            }
            if (controller == _authenticatorController) {
              _authenticatorController.text = code;
            }
            // TODO:校验验证码正确与否
          },
          onEditing: (isEditing) {
            if (isEditing && _keyboardIsShow == false) {
              _keyboardIsShow = true;
              _scrollToBottom();
            }
          },
          errorText: errorText, // 添加 errorText 参数
        ),
        const SizedBox(height: 30),
      ],
    );
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
                                  _buildVerificationCodeInput(_smsVerificationController, 'Verification code', errorText: _smsErrorText),
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
                                  _buildVerificationCodeInput(_authenticatorController, 'Authenticator code', errorText: _authenticatorErrorText),
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