// To parse this JSON data, do
//
//     final EnterDetails = EnterDetailsFromJson(jsonString);

import 'dart:convert';

EnterDetails EnterDetailsFromJson(String str) =>
    EnterDetails.fromJson(json.decode(str));

String EnterDetailsToJson(EnterDetails data) => json.encode(data.toJson());

class EnterDetails {
  EnterDetails({
    required this.name,
    required this.uid,
    required this.villagename,
    required this.districtname,
    required this.pincode,
    required this.phonenum
  });

  final String name;
  final String uid;
  final String villagename;
  final String districtname;
  
  final String pincode;
  final String phonenum;

  factory EnterDetails.fromJson(Map<String, dynamic> json) => EnterDetails(
        name: json["name"],
        uid: json["uid"],
        villagename: json[" villagename"],
        districtname: json["districtname"],
        pincode: json["pincode"],
        phonenum: json["phonenum"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "villagename": villagename,
        "districtname": districtname,
        "pincode": pincode,
        "phonenum":phonenum
      };
}
