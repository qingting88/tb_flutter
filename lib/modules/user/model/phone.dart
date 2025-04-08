class IPhone {
  final String phoneCountryCode;
  final String phoneCountryCodeShort; // e.g. "CN"
  final String phoneNumber;

  IPhone({
    required this.phoneCountryCode,
    required this.phoneCountryCodeShort,
    required this.phoneNumber,
  });

  factory IPhone.fromJson(Map<String, dynamic> json) {
    return IPhone(
      phoneCountryCode: json['phone_country_code'],
      phoneCountryCodeShort: json['phone_country_code_short'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_country_code': phoneCountryCode,
      'phone_country_code_short': phoneCountryCodeShort,
      'phone_number': phoneNumber,
    };
  }
}