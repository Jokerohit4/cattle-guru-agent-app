// // To parse this JSON data, do
// //
// //     final Cartmodel = CartmodelFromJson(jsonString);

// import 'dart:convert';

// Cartmodel CartmodelFromJson(String str) => Cartmodel.fromJson(json.decode(str));

// String CartmodelToJson(Cartmodel data) => json.encode(data.toJson());

// class Cartmodel {
//   Cartmodel(
//       {required this.name,
//       required this.villagename,
//       required this.district,
//       required this.pincode,
//       required this.products,
//       required this.phonenum,
//       required this.crtprod});

//   final String name;
//   final String villagename;
//   final String district;
//   final String phonenum;
//   final String pincode;
//   final String products;
//   List<Crtprod>? crtprod;

//   factory Cartmodel.fromJson(Map<String, dynamic> json) => Cartmodel(
//       name: json["customername"],
//       villagename: json[" villagename"],
//       district: json["district"],
//       phonenum: json["phonenum"],
//       pincode: json["pincode"],
//       products: json["products"],
//       crtprod =
//       json['crtprod'].forEach((v) {
//         crtprod!.add(new Crtprod.fromJson(v));
//       }),
// }
//       );

//   Map<String, dynamic> toJson() => {
//         "customername": name,
//         "villagename": villagename,
//         "phonenum": phonenum,
//         "district": district,
//         "pincode": pincode,
//         "products": products,
//         "crtpod":crtprod
//       };
// }

// class Crtprod {
//   String? image;
//   String? quantity;
//   String? price;
//   String? name;
//   String? description;
//   String? disprice;
//   String? wt;

//   Crtprod(
//       {this.image,
//       this.quantity,
//       this.price,
//       this.name,
//       this.description,
//       this.disprice,
//       this.wt});

//   factory Crtprod.fromJson(Map<String, dynamic> json)  => Crtprod({
//     image = json['image'],
//     quantity = json['quantity'],
//     price = json['price'];
//     name = json['name'];
//     description = json['description'];
//     disprice = json['disprice'];
//     wt = json['wt'];
//   }
//   );
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['disprice'] = this.disprice;
//     data['wt'] = this.wt;
//     return data;
//   }
// }

class Crtprod {
  String? image;
  String? quantity;
  String? price;
  String? name;
  String? description;
  String? disprice;
  String? wt;

  Crtprod(
      {this.image,
      this.quantity,
      this.price,
      this.name,
      this.description,
      this.disprice,
      this.wt});

  Crtprod.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    description = json['description'];
    disprice = json['disprice'];
    wt = json['wt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['name'] = this.name;
    data['description'] = this.description;
    data['disprice'] = this.disprice;
    data['wt'] = this.wt;
    return data;
  }
}
