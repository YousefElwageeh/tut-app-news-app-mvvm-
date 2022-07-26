import 'dart:convert';

class ForgotPasswordRequset {
  String email;
  ForgotPasswordRequset({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  factory ForgotPasswordRequset.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordRequset(
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordRequset.fromJson(String source) =>
      ForgotPasswordRequset.fromMap(json.decode(source));
}
