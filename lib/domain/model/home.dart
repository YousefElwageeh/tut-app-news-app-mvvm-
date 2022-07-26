import 'dart:convert';

import 'package:advanced_flutter_arabic/domain/model/models.dart';

class Home extends BaseModel {
  Data? data;
  Home({
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data?.toMap(),
    };
  }

  factory Home.fromMap(Map<String, dynamic> map) {
    return Home(
      data: map['data'] != null ? Data.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Home.fromJson(String source) => Home.fromMap(json.decode(source));
}

class Data {
  List<Services> services;
  List<Banners> banners;
  List<Stores> stores;
  Data({
    required this.services,
    required this.banners,
    required this.stores,
  });

  Map<String, dynamic> toMap() {
    return {
      'services': services.map((x) => x.toMap()).toList(),
      'banners': banners.map((x) => x.toMap()).toList(),
      'stores': stores.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      services: List<Services>.from(
          map['services']?.map((x) => Services.fromMap(x)) ?? const []),
      banners: List<Banners>.from(
          map['banners']?.map((x) => Banners.fromMap(x)) ?? const []),
      stores: List<Stores>.from(
          map['stores']?.map((x) => Stores.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));
}

class Services {
  int id;
  String title;
  String image;
  Services({
    required this.id,
    required this.title,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory Services.fromMap(Map<String, dynamic> map) {
    return Services(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Services.fromJson(String source) =>
      Services.fromMap(json.decode(source));
}

class Banners {
  int id;
  String link;
  String title;
  String image;
  Banners({
    required this.id,
    required this.link,
    required this.title,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'link': link,
      'title': title,
      'image': image,
    };
  }

  factory Banners.fromMap(Map<String, dynamic> map) {
    return Banners(
      id: map['id']?.toInt() ?? 0,
      link: map['link'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Banners.fromJson(String source) =>
      Banners.fromMap(json.decode(source));
}

class Stores {
  int id;
  String title;
  String image;
  Stores({
    required this.id,
    required this.title,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory Stores.fromMap(Map<String, dynamic> map) {
    return Stores(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Stores.fromJson(String source) => Stores.fromMap(json.decode(source));
}
