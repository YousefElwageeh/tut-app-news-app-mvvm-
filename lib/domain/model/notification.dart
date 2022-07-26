import 'dart:convert';

class NotificationModel {
  int status;
  String message;
  List<Data> data;
  NotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      status: map['status']?.toInt() ?? 0,
      message: map['message'] ?? '',
      data:
          List<Data>.from(map['data']?.map((x) => Data.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}

class Data {
  int id;
  String name;
  String username;
  String title;
  String body;
  String image;
  String email;
  String time;
  String bs;
  Data({
    required this.id,
    required this.name,
    required this.username,
    required this.title,
    required this.body,
    required this.image,
    required this.email,
    required this.time,
    required this.bs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'title': title,
      'body': body,
      'image': image,
      'email': email,
      'time': time,
      'bs': bs,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      image: map['image'] ?? '',
      email: map['email'] ?? '',
      time: map['time'] ?? '',
      bs: map['bs'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));
}
