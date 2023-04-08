import 'package:cattle_guru_agent_app/controllers/enter_your_details_controller.dart';
import 'package:cattle_guru_agent_app/models/Enter_details_model.dart';

import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({super.key});

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final List<String> items = [
    'Sports',
    'Sports1',
    'Sports2',
    'Sports3',
    'Sports4',
    'Sports5',
    'Sports6',
    'Sports7',
  ];
  String? selectedValue = "";
  @override
  Widget build(BuildContext context) {
    List<dynamic> items = [];
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController controller = new TextEditingController();
    return Scaffold(
      body: GetBuilder<EnterDetailsController>(
          init: EnterDetailsController(),
          builder: (controller) {
            return Form(
              key: controller.detailskey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth / 5),
                      child: Image.asset(
                        applogo,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Guru PashuMitra",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth / 20,
                          top: screenHeight / 20,
                          bottom: screenHeight / 20),
                      child: Text(
                        "Enter Your Details",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth / 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texthead("Your Name*"),
                          CustomInputContainer(controller.namecontroller,
                              "Enter Your Name", TextInputType.name),
                          texthead("Village Name*"),
                          CustomInputContainer(controller.villagenamecontroller,
                              "Enter Village Name", TextInputType.name),
                          texthead("District Name*"),
                          CustomInputContainer(controller.districtnamecontroller, "Enter district Name", TextInputType.name),
                          texthead("Pincode(Optional)"),
                          CustomInputContainer(controller.pincodecontroller,
                              "Enter Pincode", TextInputType.number)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenWidth / 15),
                      child: CustomButton(
                        inptheight: 16,
                        inptwidth: 1.2,
                        inpttxt: "Continue",
                        color: Colors.orange,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        press: () {
                          EnterDetails enterDetails = EnterDetails(
                              name: controller.namecontroller.text,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              villagename:
                                  controller.villagenamecontroller.text,
                              districtname:
                                  controller.districtnamecontroller.text,
                              pincode: controller.pincodecontroller.text,
                              phonenum: FirebaseAuth.instance.currentUser?.phoneNumber ?? ""
                              );
                          controller.addUserInfo(enterDetails);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget texthead(String head) {
    return Text(
      head,
      style: TextStyle(
          fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
    );
  }

  Widget CustomInputContainer(TextEditingController textEditingController,
      String hintText, TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
      child: CustomInputField(
        controller: textEditingController,
        hintText: hintText,
        textInputType: textInputType,
      ),
    );
  }
}
