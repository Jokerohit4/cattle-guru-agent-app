import 'package:cattle_guru_agent_app/models/Customer_details_model.dart';
import 'package:cattle_guru_agent_app/models/Enter_details_model.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Add_customer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsController extends GetxController
{
  final GlobalKey<FormState> customerdetailskey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonenum = TextEditingController();
  TextEditingController villagenamecontroller = TextEditingController();
  TextEditingController districtnamecontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController buffaloescontroller = TextEditingController();
  TextEditingController cowcontroller = TextEditingController();

  Future<dynamic> addUserInfo(CustomerDetails customerDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("customerdetails").doc(customerDetails.phonenum)
        .set(customerDetails.toJson())
        .then((value) => Get.to(() => AddCustomerScreen()))
        .catchError((error) => print("Failed to send details: $error"));
  }
}