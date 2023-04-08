// To parse this JSON data, do
//
//     final Product = ProductFromJson(jsonString);

import 'dart:convert';

import 'package:get_storage/get_storage.dart';

Product ProductFromJson(String str) => Product.fromJson(json.decode(str));

String ProductToJson(Product data) => json.encode(data.toJson());

class Product {
  Product(
      {required this.fullname,
      required this.earning,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.totalwt,
      required this.totalamt,
      required this.image4,
      required this.description,
      required this.costperkg});

  final String fullname;
  final String earning;
  final String image1;
  final String image2;
  final String image3;
  final String totalwt;
  final String totalamt;
  final String image4;
  final String costperkg;
  final String description;
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      fullname: json["fullname"],
      costperkg: json["costperkg"],
      earning: json["earning"],
      image1: json["image1"],
      image2: json["image2"],
      image3: json["image3"],
      totalwt: json["totalwt"],
      totalamt: json["totalamt"],
      image4: json["image4"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "costperkg":costperkg,
        "earning": earning,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "totalwt": totalwt,
        "totalamt":totalamt,
        "image4": image4,
        "description": description
      };
}
