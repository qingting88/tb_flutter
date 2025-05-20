import 'package:flutter/material.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';
import 'package:tb_flutter/core/widgets/app_text_field.dart';

final hasLenChart = RegExp(r'^.{8,20}$');
final hasUppercase = RegExp(r'(?=.*?[A-Z])');
final hasLowercase = RegExp(r'(?=.*?[a-z])');
final hasDigit = RegExp(r'(?=.*?[0-9])');
final hasSpecial = RegExp(r'(?=.*?[^0-9a-zA-Z\n])');

class PasswordFields extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueChanged<bool>? onValidationChanged; // 回调验证状态变化

  const PasswordFields({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    this.onValidationChanged,
  });

  @override
  _PasswordFieldsState createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  bool _isPasswordValid = false;
  bool _passwordsMatch = false;

  @override
  void initState() {
    super.initState();
    // 监听控制器变化
    widget.passwordController.addListener(_validatePassword);
    widget.confirmPasswordController.addListener(
      _validateConfirmPassword,
    );
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(_validatePassword);
    widget.confirmPasswordController.removeListener(_validateConfirmPassword);
    super.dispose();
  }

  void _validatePassword() {
    final password = widget.passwordController.text;
    setState(() {
      _isPasswordValid = _checkPasswordRules(password);
      _passwordsMatch = password == widget.confirmPasswordController.text;
    });
    _notifyValidationState();
  }

  void _validateConfirmPassword() {
    setState(() {
      _passwordsMatch =
          widget.passwordController.text ==
          widget.confirmPasswordController.text;
    });
    _notifyValidationState();
  }

  void _notifyValidationState() {
    if (widget.onValidationChanged != null) {
      widget.onValidationChanged!(_isPasswordValid && _passwordsMatch);
    }
  }

  bool _checkPasswordRules(String password) {
    // 6-8位长度
    if (!password.contains(hasLenChart)) return false;
    // if (password.length < 20 || password.length > 8) return false;
    // 必须包含大写字母
    if (!password.contains(hasUppercase)) return false;
    // 必须包含小写字母
    if (!password.contains(hasLowercase)) return false;
    // 必须包含数字
    if (!password.contains(hasDigit)) return false;
    // 不准有特殊字符（只允许字母和数字）
    if (!password.contains(hasSpecial)) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AppTextField(
            autofocus: true,
            hintText: 'Enter password',
            controller: widget.passwordController,
            // keyboardType: TextInputType.visiblePassword,
            // obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return " "; //'请输入密码';
              }
              if (!_checkPasswordRules(value)) {
                return " "; //'密码不符合规则';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          child: AppTextField(
            autofocus: true,
            hintText: 'Enter password again',
            controller: widget.confirmPasswordController,
            // keyboardType: TextInputType.visiblePassword,
            // obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return " "; //'请再次输入密码';
              }
              if (value != widget.passwordController.text) {
                return '两次输入的密码不一致';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: _buildPasswordRules(),
        ),
      ],
    );
  }

  Widget _buildPasswordRules() {
    final password = widget.passwordController.text;
    final rules = [
      {
        'description': '8-20 characters',
        'valid': password.contains(hasLenChart),
      },
      {
        'description': 'At least one uppercase letter',
        'valid': password.contains(hasUppercase),
      },
      {
        'description': 'At least one lowercase letter',
        'valid': password.contains(hasLowercase),
      },
      {
        'description': 'At least one digit',
        'valid': password.contains(hasDigit),
      },
      {
        'description': 'At least one special character',
        'valid': password.contains(hasSpecial),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          spacing: 4,
          children:
              rules.map((rule) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color:
                            rule['valid'] as bool
                                ? AppTheme.successColor
                                : AppTheme.labelColor,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        rule['description'] as String,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
        // SizedBox(height: 8),
        // if (_passwordController.text.isNotEmpty &&
        //     _confirmPasswordController.text.isNotEmpty)
        //   Text(
        //     _passwordsMatch ? '密码匹配 ✓' : '密码不匹配 ✗',
        //     style: TextStyle(
        //       color: _passwordsMatch ? Colors.green : Colors.red,
        //     ),
        //   ),
      ],
    );
  }
}
