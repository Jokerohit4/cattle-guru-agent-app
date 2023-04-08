// To parse this JSON data, do
//
//     final CustomerDetails = CustomerDetailsFromJson(jsonString);

import 'dart:convert';

CustomerDetails CustomerDetailsFromJson(String str) =>
    CustomerDetails.fromJson(json.decode(str));

String CustomerDetailsToJson(CustomerDetails data) => json.encode(data.toJson());

class CustomerDetails {
  CustomerDetails({
    required this.name,
    required this.uid,
    required this.phonenum,
    required this.villagename,
    required this.district,
    required this.pincode,
    required this.buffaloes,
    required this.cows
  });

  final String name;
  final String uid;
  final String phonenum;
  final String villagename;
  final String district;
  final String pincode;
  final String buffaloes;
  final String cows;

  factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
        name: json["name"],
        uid: json["uid"],
        phonenum: json["phonenum"],
        villagename: json["villagename"],
        district: json["district"],
        pincode: json["pincode"],
        buffaloes: json["buffaloes"],
        cows: json["cows"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "phonenum": phonenum,
        "villagename": villagename,
        "district": district,
        "pincode":pincode,
        "buffaloes":buffaloes,
        "cows":cows
      };
}
