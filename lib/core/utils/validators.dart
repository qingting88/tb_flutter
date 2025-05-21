import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  static String? validateVerificationCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter verification code';
    }
    if (value.length != 4) {
      return 'Verification code must be 4 digits';
    }
    return null;
  }
}
