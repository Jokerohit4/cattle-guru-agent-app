import 'package:cattle_guru_agent_app/models/Bank_details_model.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Customer_details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBankDetailsController extends GetxController
{
  final GlobalKey<FormState> editbankdetailskey = GlobalKey<FormState>();
  TextEditingController banknamecontroller = TextEditingController();
  TextEditingController acctholdernamecontroller = TextEditingController();
  TextEditingController acctnumbcontroller = TextEditingController();
  TextEditingController ifscnumcontroller = TextEditingController();

  Future<dynamic> addUserInfo(EditBankDetails editBankDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("bankdetails").doc(acctnumbcontroller.text)
        .set(editBankDetails.toJson())
        .then((value) => Get.to(() => HomeScreen() ))
        .catchError((error) => print("Failed to send details: $error"));
  }
}