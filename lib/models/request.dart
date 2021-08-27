import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String name;
  String phone;
  String bloodGroup;
  String hospital;
  String city;
  Timestamp date;
  Request(
      {required this.date,
      required this.name,
      required this.phone,
      required this.hospital,
      required this.city,
      required this.bloodGroup});
  factory Request.fromJson(Map<String, dynamic> json) => Request(
        bloodGroup: json["blood_group"],
        city: json["city"],
        name: json['name'],
        phone: json['phone'],
        date: json["date"],
        hospital: json["hospital"],
      );

  Map<String, dynamic> toJson() => {
        "blood_group": bloodGroup,
        "city": city,
        "date": date,
        "hospital": hospital,
      };
}
