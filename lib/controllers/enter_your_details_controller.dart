import 'package:cattle_guru_agent_app/models/Enter_details_model.dart';
import 'package:cattle_guru_agent_app/screens/Allow_Location_acess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EnterDetailsController extends GetxController {
  final GlobalKey<FormState> detailskey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController villagenamecontroller = TextEditingController();
  TextEditingController districtnamecontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();

  Future<dynamic> addUserInfo(EnterDetails EnterDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .set(EnterDetails.toJson())
        .then((value) => Get.to(() => AllowLocationAcessScreen()))
        .catchError((error) => print("Failed to send details: $error"));
  }
}
