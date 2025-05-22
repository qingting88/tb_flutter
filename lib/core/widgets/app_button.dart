import 'package:flutter/material.dart';
import 'package:tb_flutter/core/config/app_theme.dart';

enum ButtonType { primary, secondary, error }

enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final bool isLoading;
  final bool disabled;
  final ButtonType buttonType;
  final ButtonSize buttonSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.disabled = false,
    this.buttonType = ButtonType.primary,
    this.buttonSize = ButtonSize.large,
    this.prefixIcon,
    this.suffixIcon,
  });

  _getThemeColor() {
    const colors = {
      ButtonType.primary: AppTheme.primaryColor,
      ButtonType.secondary: AppTheme.accentColor,
      ButtonType.error: AppTheme.errorColor,
    };
    return colors[buttonType];
  }

  _getThemeSize() {
    const sizes = {
      ButtonSize.small: Size.fromHeight(36),
      ButtonSize.medium: Size.fromHeight(40),
      ButtonSize.large: Size.fromHeight(60),
    };
    return sizes[buttonSize];
  }

  _getThemeTextSize() {
    const textStyles = {
      ButtonSize.small: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        height: 1.25,
      ),
      ButtonSize.medium: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        height: 1.25,
      ),
      ButtonSize.large: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1
      ),
    };
    return textStyles[buttonSize];
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (disabled || isLoading) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled ? AppTheme.labelColor : _getThemeColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 0),
        fixedSize: _getThemeSize(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(width: 8),
          ] else if (prefixIcon != null) ...[
            prefixIcon!,
            const SizedBox(width: 8),
          ],
          Text(text, style: _getThemeTextSize()),
          if (suffixIcon != null) ...[const SizedBox(width: 8), suffixIcon!],
        ],
      ),
    );
  }
}
