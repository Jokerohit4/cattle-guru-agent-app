import 'package:cattle_guru_agent_app/screens/Select_app_lang_screen.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cattle_guru_agent_app/widgets/Phone_whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController controller = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange.shade50,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "My Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          PhoneWhatsapp()
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                texthead("Your Name*"),
                CustomInputContainer(controller, "Name"),
                texthead("Village Name*"),
                CustomInputContainer(controller, "Village"),
                texthead("District*"),
                CustomInputContainer(controller, "Select District"),
                texthead("Pincode"),
                CustomInputContainer(controller, "Pincode")
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: screenHeight/10,
        child: CustomButton(
          inptheight: 16,
          inptwidth: 1.2,
          inpttxt: "Save",
          color: Colors.orange,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
          press: () {
            Get.to(() => SelectAppLangScreen());
          },
        ),
      ),
    );
  }

  Widget texthead(String head) {
    return Text(
      head,
      style: TextStyle(
          fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
    );
  }

  Widget CustomInputContainer(
      TextEditingController textEditingController, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
      child: CustomInputField(
          controller: textEditingController, hintText: hintText),
    );
  }
}
