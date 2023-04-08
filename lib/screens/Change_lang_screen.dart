import 'package:cattle_guru_agent_app/screens/Edit_bank_details.dart';
import 'package:cattle_guru_agent_app/screens/Select_app_lang_screen.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "Select Language",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 5),
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
            ],
          ),
          Column(
            children: [
              Text(
                "Please Select app language",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenHeight / 20,
              ),
              CustomButton(
                inptheight: 16,
                inptwidth: 1.2,
                inpttxt: "Hindi",
                color: Colors.orange.shade50,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                press: () {
                  Get.to(() => SelectAppLangScreen());
                },
              ),
              SizedBox(
                height: screenHeight / 80,
              ),
              CustomButton(
                inptheight: 16,
                inptwidth: 1.2,
                inpttxt: "English",
                color: Colors.orange,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                press: () {
                  Get.to(() => SelectAppLangScreen());
                },
              ),
            ],
          ),
          CustomButton(
            inptheight: 16,
            inptwidth: 1.2,
            inpttxt: "Save",
            color: Colors.orange,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
            press: () {
              Get.to(() => EditBankDetailsScreen());
            },
          ),
        ],
      ),
    );
  }
}
