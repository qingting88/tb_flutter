import 'package:flutter/material.dart';
import 'package:tb_flutter/core/config/app_theme.dart';

enum InputTheme { border, filled }

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool? autofocus;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autofocus,
    this.onChanged,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: autofocus ?? false,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.2),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        hintStyle: Theme.of(context).textTheme.bodySmall,
        errorStyle: TextStyle(
          fontSize: 12,
          color: AppTheme.errorColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.borderColor, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.secondaryColor, width: 1.5),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.errorColor, width: 1.5),
        ),
        // focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Theme.of(context).colorScheme.errorContainer)),
      ),
    );
  }
}
