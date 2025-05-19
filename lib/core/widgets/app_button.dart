import 'package:flutter/material.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';

enum ButtonType { primary, secondary, tertiary }

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
    this.buttonSize = ButtonSize.medium,
    this.prefixIcon,
    this.suffixIcon,
  });

  _getThemeColor() {
    const colors = {
      ButtonType.primary: AppTheme.primaryColor,
      ButtonType.secondary: AppTheme.secondaryColor,
      ButtonType.tertiary: AppTheme.accentColor,
    };
    return colors[buttonType];
  }

  _getThemeSize() {
    const sizes = {
      ButtonSize.small: EdgeInsets.symmetric(vertical: 16),
      ButtonSize.medium: EdgeInsets.symmetric(vertical: 20),
      ButtonSize.large: EdgeInsets.symmetric(vertical: 32),
    };
    return sizes[buttonSize];
  }

  _getThemeTextSize() {
    const textStyles = {
      ButtonSize.small: TextStyle(color: Colors.white, fontSize: 12),
      ButtonSize.medium: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        height: 1.25,
      ),
      ButtonSize.large: TextStyle(color: Colors.white, fontSize: 20),
    };
    return textStyles[buttonSize];
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (disabled || isLoading) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled ? AppTheme.labelColor : _getThemeColor(),
        padding: _getThemeSize(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: const Size(double.infinity, 60),
      ),
      child:
          isLoading
              ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  Text(text, style: _getThemeTextSize()),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    suffixIcon!,
                  ],
                ],
              ),
    );
  }
}
