// onboarding models
import 'dart:convert';

abstract class BaseModel {
  String? message;
  int? status;
}

// login models

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'numOfNotifications': numOfNotifications,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      map['id'] ?? '',
      map['name'] ?? '',
      map['numOfNotifications']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'link': link,
    };
  }

  factory Contacts.fromMap(Map<String, dynamic> map) {
    return Contacts(
      map['phone'] ?? '',
      map['email'] ?? '',
      map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Contacts.fromJson(String source) =>
      Contacts.fromMap(json.decode(source));
}

class Authentication {
  int status;
  String message;
  Customer? customer;
  Contacts? contacts;
  Authentication({
    required this.status,
    required this.message,
    this.customer,
    this.contacts,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'customer': customer?.toMap(),
      'contacts': contacts?.toMap(),
    };
  }

  factory Authentication.fromMap(Map<String, dynamic> map) {
    return Authentication(
      status: map['status']?.toInt() ?? 0,
      message: map['message'] ?? '',
      customer:
          map['customer'] != null ? Customer.fromMap(map['customer']) : null,
      contacts:
          map['contacts'] != null ? Contacts.fromMap(map['contacts']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Authentication.fromJson(String source) =>
      Authentication.fromMap(json.decode(source));
}
