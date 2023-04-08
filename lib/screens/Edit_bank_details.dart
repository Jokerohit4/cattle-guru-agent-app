import 'package:cattle_guru_agent_app/controllers/Edit_bank_details_controller.dart';
import 'package:cattle_guru_agent_app/models/Bank_details_model.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_AppBar.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cattle_guru_agent_app/widgets/Phone_whatsapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class EditBankDetailsScreen extends StatefulWidget {
  late int tabIndex;
  EditBankDetailsScreen({super.key, this.tabIndex = 0});

  @override
  State<EditBankDetailsScreen> createState() => _EditBankDetailsScreenState();
}

class _EditBankDetailsScreenState extends State<EditBankDetailsScreen> {
  void changeTabIndex(int index) {
    setState(() {
      widget.tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController controller = new TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Bank Details", phonewhat: false),
      body: GetBuilder<EditBankDetailsController>(
          init: EditBankDetailsController(),
          builder: (controller) {
            return Form(
              key: controller.editbankdetailskey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 2.0),
                                child: const Center(
                                  child: Text(
                                    "Your Earnings will be transferred to below account",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth / 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Enter Bank Details",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    CustomButton(
                                      inptheight: 20,
                                      inptwidth: 5,
                                      inpttxt: "Edit",
                                      color: Colors.orange,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                      press: () {
                                        // Get.to(() => SelectAppLangScreen());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth / 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                texthead("Bank Name*"),
                                CustomInputContainer(
                                    controller.banknamecontroller,
                                    "Enter Bank Name",
                                    TextInputType.name),
                                texthead("Account Holder Name*"),
                                CustomInputContainer(
                                    controller.acctholdernamecontroller,
                                    "Enter Account Holder Name",
                                    TextInputType.name),
                                texthead("IFSC Name*"),
                                CustomInputContainer(
                                    controller.ifscnumcontroller,
                                    "Enter IFSC Name",
                                    TextInputType.text),
                                texthead("Account Number"),
                                CustomInputContainer(
                                    controller.acctnumbcontroller,
                                    "Enter Account Number",
                                    TextInputType.number)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            inptheight: 16,
                            inptwidth: 1.15,
                            inpttxt: "Save",
                            color: Colors.orange,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            press: () {
                              EditBankDetails editBankDetails = EditBankDetails(
                                  bankname: controller.banknamecontroller.text,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  ifsccode: controller.ifscnumcontroller.text,
                                  acctholdername:
                                      controller.acctholdernamecontroller.text,
                                  acctnum: controller.acctnumbcontroller.text);
                              controller.addUserInfo(editBankDetails);
                              // Get.to(() => SelectAppLangScreen());
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Need help?",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              PhoneWhatsapp(
                                h: 0.75,
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kPrimaryColor)),
        ),
        height: 80,
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: kPrimaryColor,
          onTap: changeTabIndex,
          iconSize: 15.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.tabIndex,
          items: [
            _bottomNavigationBarItem(
              icon: home,
              selected: widget.tabIndex == 0 ? true : false,
              label: "Home",
            ),
            _bottomNavigationBarItem(
              icon: fornewcustomer,
              selected: widget.tabIndex == 1 ? true : false,
              label: "New Orders",
            ),
            _bottomNavigationBarItem(
              selected: widget.tabIndex == 2 ? true : false,
              icon: productsic,
              label: "Products",
            ),
            _bottomNavigationBarItem(
              selected: widget.tabIndex == 3 ? true : false,
              icon: earnings,
              label: "My Earnings",
            ),
          ],
        ),
      ),
    );
  }

  _bottomNavigationBarItem(
      {required String icon, required String label, required bool selected}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        scale: 1.7,
        height: 28,
        color: Colors.black54,
      ),
      activeIcon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(icon, scale: 1, height: 30, color: Colors.white),
          )),
      label: label,
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
