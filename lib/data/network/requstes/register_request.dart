import 'dart:convert';

class RegisterRequest {
  String? userName;
  String? countryMobileCode;
  String? mobileNumber;
  String? email;
  String? password;
  String? profilePicture;
  RegisterRequest({
    this.userName,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'countryMobileCode': countryMobileCode,
      'mobileNumber': mobileNumber,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      userName: map['userName'],
      countryMobileCode: map['countryMobileCode'],
      mobileNumber: map['mobileNumber'],
      email: map['email'],
      password: map['password'],
      profilePicture: map['profilePicture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source));
}
