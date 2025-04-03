import 'package:flutter/material.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';

class VerificationCodeInput extends StatefulWidget {
  final void Function(String) onCompleted;
  final int length;

  const VerificationCodeInput({super.key,  required this.length, required this.onCompleted});

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
          (index) => FocusNode(),
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
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }

      setState(() {
        _codeDigits[index] = value;
      });

      // 检查是否所有数字都已输入
      final allDigitsFilled = _codeDigits.every((digit) => digit.isNotEmpty);
      if (allDigitsFilled) {
        widget.onCompleted(_codeDigits.join());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
              fillColor: Colors.transparent,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _onCodeDigitChanged(index, value);
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
    );
  }
}
