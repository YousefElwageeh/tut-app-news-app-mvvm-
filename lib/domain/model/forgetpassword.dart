import 'dart:convert';

class ForgotPasswordModel {
  int? status;
  String? message;
  String? support;

  ForgotPasswordModel({this.status, this.message, this.support});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'support': support,
    };
  }

  factory ForgotPasswordModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordModel(
      status: map['status']?.toInt(),
      message: map['message'],
      support: map['support'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordModel.fromJson(String source) =>
      ForgotPasswordModel.fromMap(json.decode(source));
}
