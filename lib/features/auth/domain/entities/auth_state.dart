import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  String? _email;
  String? _verificationCode;
  String? _password;
  bool _isRegistrationComplete = false;

  String? get email => _email;
  String? get verificationCode => _verificationCode;
  String? get password => _password;
  bool get isRegistrationComplete => _isRegistrationComplete;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void completeRegistration() {
    _isRegistrationComplete = true;
    notifyListeners();
  }

  void reset() {
    _email = null;
    _verificationCode = null;
    _password = null;
    _isRegistrationComplete = false;
    notifyListeners();
  }
}
