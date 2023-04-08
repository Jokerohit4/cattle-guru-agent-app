// To parse this JSON data, do
//
//     final EditBankDetails = EditBankDetailsFromJson(jsonString);

import 'dart:convert';

EditBankDetails EditBankDetailsFromJson(String str) =>
    EditBankDetails.fromJson(json.decode(str));

String EditBankDetailsToJson(EditBankDetails data) => json.encode(data.toJson());

class EditBankDetails {
  EditBankDetails({
    required this.bankname,
    required this.uid,
    required this.ifsccode,
    required this.acctholdername,
    required this.acctnum,
  });

  final String bankname;
  final String uid;
  final String ifsccode;
  final String acctholdername;
  final String acctnum;

  factory EditBankDetails.fromJson(Map<String, dynamic> json) => EditBankDetails(
        bankname: json["bankname"],
        uid: json["uid"],
        ifsccode: json[" ifsccode"],
        acctholdername: json["acctholdername"],
        acctnum: json["acctnum"],
      );

  Map<String, dynamic> toJson() => {
        "bankname": bankname,
        "uid": uid,
        "ifsccode": ifsccode,
        "acctholdername": acctholdername,
        "acctnum": acctnum,
      };
}
