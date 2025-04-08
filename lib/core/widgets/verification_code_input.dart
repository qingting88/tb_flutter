import 'package:flutter/material.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';

// file:/Users/zhangfei/Documents/GitHub/tb_flutter/lib/core/widgets/verification_code_input.dart
class VerificationCodeInput extends StatefulWidget {
  final void Function(String)? onCompleted;
  final void Function(bool)? onEditing;
  final int length;
  final String? errorText; // errorText 参数

  const VerificationCodeInput({
    super.key,
    required this.length,
    this.onCompleted,
    this.onEditing,
    this.errorText, // 传递 errorText
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  late List<TextEditingController> _controllers = [];
  late List<FocusNode> _focusNodes = [];
  late List<String> _codeDigits = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) {
        final focusNode = FocusNode();
        focusNode.addListener(() {
          if (focusNode.hasFocus && widget.onEditing != null) {
            widget.onEditing!(true);
          }
        });
        return focusNode;
      },
    );
    _codeDigits = List.filled(
      widget.length,
      '',
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onCodeDigitChanged(int index, String value) {
    if (value.isNotEmpty && value.trim().isNotEmpty) { // 确保输入的是数字
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }

      setState(() {
        _codeDigits[index] = value.trim(); // 去除空格
      });

      // 检查是否所有数字都已输入
      final allDigitsFilled = _codeDigits.every((digit) => digit.isNotEmpty);
      if (allDigitsFilled) {
        widget.onCompleted?.call(_codeDigits.join());
      }
    } else if (value.isEmpty && index > 0) {
      // 用户删除了一个数字，将焦点移回上一个输入框
      _focusNodes[index - 1].requestFocus();
      setState(() {
        _codeDigits[index] = '';
      });
    }
  }

  bool _isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.length,
            (index) => SizedBox(
              width: 50,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: '',
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
                  ),
                  filled: true,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    // 检查输入是否为数字
                    if (_isNumeric(value.trim())) {
                      _onCodeDigitChanged(index, value);
                    } else {
                      // 删除非数字字符
                      _controllers[index].text = '';
                    }
                  } else if (value.isEmpty && index > 0) {
                    // 用户删除了一个数字，将焦点移回上一个输入框
                    _focusNodes[index - 1].requestFocus();
                    setState(() {
                      _codeDigits[index] = '';
                    });
                  }
                },
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}