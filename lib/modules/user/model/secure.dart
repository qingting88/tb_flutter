class ISecureSetting {
  final bool twoFactor;
  final bool emailVerify;
  final bool phoneVerify;

  ISecureSetting({
    required this.twoFactor,
    required this.emailVerify,
    required this.phoneVerify,
  });

  factory ISecureSetting.fromJson(Map<String, dynamic> json) {
    return ISecureSetting(
      twoFactor: json['two_factor'],
      emailVerify: json['email_verify'],
      phoneVerify: json['phone_verify'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'two_factor': twoFactor,
      'email_verify': emailVerify,
      'phone_verify': phoneVerify,
    };
  }
}

class IGoogleKeyQuery {
  final String secretKey;
  final String qrCode;

  IGoogleKeyQuery({required this.secretKey, required this.qrCode});

  factory IGoogleKeyQuery.fromJson(Map<String, dynamic> json) {
    return IGoogleKeyQuery(
      secretKey: json['secret_key'],
      qrCode: json['qr_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'secret_key': secretKey, 'qr_code': qrCode};
  }
}

class I2FAQuery {
  final String verifyUuid;
  final ISecureSetting secure;

  I2FAQuery({required this.verifyUuid, required this.secure});

  factory I2FAQuery.fromJson(Map<String, dynamic> json) {
    return I2FAQuery(
      verifyUuid: json['verify_uuid'],
      secure: ISecureSetting.fromJson(json['secure']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'verify_uuid': verifyUuid, 'secure': secure};
  }
}
