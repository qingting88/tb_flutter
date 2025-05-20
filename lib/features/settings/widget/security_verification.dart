import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:tb_flutter/core/http/http_model.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';

enum SecurityVerificationType { sms, google, phone }

enum SendType { initialize, sending, complete }

class SecurityVerification extends StatefulWidget {
  const SecurityVerification({
    super.key,
    this.type = SecurityVerificationType.sms,
    this.autoStart = false,
    this.countdownSeconds = 60,
    this.title,
    this.pinFocusNode,
    required this.onCompleted,
    this.onPressed,
  });

  final SecurityVerificationType type;
  final String? title;
  final int countdownSeconds;
  final bool autoStart;
  final ValueChanged<String> onCompleted;
  final Future<DataT<Map<String, String>>> Function()? onPressed;

  final FocusNode? pinFocusNode;

  @override
  _SecurityVerificationState createState() => _SecurityVerificationState();
}

class _SecurityVerificationState extends State<SecurityVerification> {
  late int _remainingSeconds;
  late SendType _sendType;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.countdownSeconds;
    _sendType = SendType.initialize;
    if (widget.autoStart) {
      _startCountdown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    if (_sendType == SendType.sending) return;

    setState(() {
      _sendType = SendType.sending;
      _remainingSeconds = widget.countdownSeconds;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() {
          _sendType = SendType.complete;
          _remainingSeconds = widget.countdownSeconds;
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _handlePress() async {
    if (_sendType == SendType.sending) return;

    // 触发外部回调
    try {
      final result = await widget.onPressed?.call();
      if (result?.status == STATUS.success.value) {
        // 开始倒计时
        _startCountdown();
        // 震动反馈
        HapticFeedback.lightImpact();
      }
    } catch (e) {
      // 处理错误
      print("e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: Theme.of(context).textTheme.displaySmall,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: AppTheme.primaryColor),
        ),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(
        bottom: BorderSide(width: 2, color: AppTheme.primaryColor),
      ),
    );
    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(bottom: BorderSide(width: 2, color: AppTheme.errorColor)),
    );

    return Column(
      spacing: 16,
      children: [
        if (widget.title != null) ...[
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Text(
                widget.title ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        Text(
          'Verification code',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Padding(
          padding: EdgeInsets.only(left: 32, right: 32, bottom: 8),
          child: Pinput(
            length: 6,
            pinAnimationType: PinAnimationType.slide,
            // controller: controller,
            // focusNode: focusNode,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            errorPinTheme: errorPinTheme,
            showCursor: true,
            onCompleted: widget.onCompleted,
          ),
        ),
        if (widget.onPressed != null && _sendType == SendType.initialize) ...[
          TextButton(
            onPressed: _handlePress,
            child: Text(
              'Send verification code',
              style: TextStyle(
                color: AppTheme.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.primaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
        if (widget.onPressed != null && _sendType == SendType.sending) ...[
          TextButton(
            onPressed: () {},
            child: Text(
              'Resend verification code(${_remainingSeconds}s)',
              style: TextStyle(color: AppTheme.labelColor, fontSize: 12),
            ),
          ),
        ],
        if (widget.onPressed != null && _sendType == SendType.complete) ...[
          TextButton(
            onPressed: _handlePress,
            child: Text(
              'Resend verification code',
              style: TextStyle(
                color: AppTheme.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.primaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
