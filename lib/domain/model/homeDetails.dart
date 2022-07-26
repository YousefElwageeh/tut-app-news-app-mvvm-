import 'dart:convert';

class HomeDetailsModel {
  int status;
  String message;
  String image;
  int id;
  String title;
  String details;
  String services;
  String about;
  HomeDetailsModel({
    required this.status,
    required this.message,
    required this.image,
    required this.id,
    required this.title,
    required this.details,
    required this.services,
    required this.about,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'image': image,
      'id': id,
      'title': title,
      'details': details,
      'services': services,
      'about': about,
    };
  }

  factory HomeDetailsModel.fromMap(Map<String, dynamic> map) {
    return HomeDetailsModel(
      status: map['status']?.toInt() ?? 0,
      message: map['message'] ?? '',
      image: map['image'] ?? '',
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      details: map['details'] ?? '',
      services: map['services'] ?? '',
      about: map['about'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeDetailsModel.fromJson(String source) =>
      HomeDetailsModel.fromMap(json.decode(source));
}
