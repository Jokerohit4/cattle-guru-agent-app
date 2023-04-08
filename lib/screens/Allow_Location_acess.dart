import 'package:cattle_guru_agent_app/screens/Select_app_lang_screen.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AllowLocationAcessScreen extends StatelessWidget {
  const AllowLocationAcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
      bottomSheet: CustomButton(
        inptheight: 16,
        inptwidth: 1.2,
        inpttxt: "Allow Location Access",
        color: Colors.orange,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
        press: () {
          Get.to(() => SelectAppLangScreen());
        },
      ),
    );
  }
}
