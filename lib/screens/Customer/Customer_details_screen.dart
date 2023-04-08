import 'package:cattle_guru_agent_app/controllers/Customer_details_controller.dart';
import 'package:cattle_guru_agent_app/models/Customer_details_model.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

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
          "Customer Details",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: GetBuilder<CustomerDetailsController>(
          init: CustomerDetailsController(),
          builder: (controller) {
          return Form(
            key: controller.customerdetailskey,
            child: ListView(
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth / 20, top: screenHeight / 80, bottom: 0),
                  child: Text(
                    "Gaurav",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth / 20,
                      top: screenWidth / 100,
                      bottom: screenWidth / 100,
                      right: screenWidth / 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight / 80),
                        child: CustomButton(
                          inptheight: 16,
                          inptwidth: 3,
                          inpttxt: "Place Order",
                          color: Colors.orange,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                          press: () {
                            // Get.to(() => EnterDetailsScreen());
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight / 80),
                        child: CustomButton(
                          inptheight: 16,
                          inptwidth: 7,
                          inpttxt: "Edit",
                          color: Colors.orange,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                          press: () {
                            // Get.to(() => EnterDetailsScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      texthead("Name*"),
                      CustomInputContainer(controller.namecontroller, "Name"),
                      texthead("Phone Number*"),
                      CustomInputContainer(controller.phonenum, "Mobile Number"),
                      texthead("Village Name*"),
                      CustomInputContainer(controller.villagenamecontroller, "Village"),
                      texthead("District*"),
                      CustomInputContainer(controller.districtnamecontroller, "Select District"),
                      texthead("Pincode"),
                      CustomInputContainer(controller.pincodecontroller, "Pincode")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 20, vertical: screenHeight / 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      texthead("Buffaloes"),
                      Container(
                        width: screenWidth / 2,
                        child: CustomInputField(
                            controller: controller.buffaloescontroller, hintText: "Enter Number"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 20, vertical: screenHeight / 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      texthead("Cows"),
                      Container(
                        width: screenWidth / 2,
                        child: CustomInputField(
                            controller: controller.cowcontroller, hintText: "Enter Number"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight / 80),
                  child: CustomButton(
                    inptheight: 16,
                    inptwidth: 1.2,
                    inpttxt: "Save",
                    color: Colors.orange,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                    press: () {
                     CustomerDetails customerDetails = CustomerDetails(name: controller.namecontroller.text, uid: FirebaseAuth.instance.currentUser!.uid, phonenum: controller.phonenum.text, villagename: controller.villagenamecontroller.text, district: controller.districtnamecontroller.text, pincode: controller.pincodecontroller.text, buffaloes: controller.buffaloescontroller.text, cows: controller.cowcontroller.text);
                      controller.addUserInfo(customerDetails);
                      // Get.to(() => EnterDetailsScreen());
                    },
                  ),
                ),
                Container(
                  height: screenHeight,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      EarningDetails(context, "Gaurav Parmar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Panwar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Parmar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Panwar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Panwar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Panwar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Panwar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Panwar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023"),
                      EarningDetails(context, "Gaurav Panwar", "01", "1344", "50",
                          "1234ABCDID", "12/03/2023")
                    ],
                  ),
                ),
              ],
            ),
          );
        }
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

  Widget EarningDetails(BuildContext context, String name, String bags,
      String orderval, String earning, String orderid, String date) {
    return Padding(
      padding:
          EdgeInsets.all(SizeConfig(context).getProportionateScreenHeight(10)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromRGBO(240, 214, 214, 0.5)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(240, 214, 214, 0.1),
                  Color.fromRGBO(240, 214, 214, 0.2),
                  Color.fromRGBO(240, 214, 214, 0.3),
                ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Order No",
                        style: TextStyle(
                            color: Color.fromARGB(255, 105, 105, 105),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              orderid,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Date:",
                        style: TextStyle(
                            color: Color.fromARGB(255, 91, 91, 91),
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            date,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig(context).getProportionatePadding(10)),
                child: const Divider(
                  height: 2.0,
                  thickness: 1.0,
                  color: Color.fromRGBO(240, 214, 214, 1),
                ),
              ),
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig(context).getProportionatePadding(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig(context).getProportionateScreenWidth(300.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Bags",
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Order Value",
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "My Earning",
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig(context)
                                        .getProportionatePadding(10.0),
                                    horizontal: SizeConfig(context)
                                        .getProportionatePadding(10.0)),
                                child: Text(bags),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.orange, width: 2.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig(context)
                                        .getProportionateScreenWidth(8.0),
                                    vertical: SizeConfig(context)
                                        .getProportionateScreenWidth(4.0)),
                                child: Text("& $orderval/-"),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.green, width: 2.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig(context)
                                        .getProportionateScreenWidth(8.0),
                                    vertical: SizeConfig(context)
                                        .getProportionateScreenWidth(4.0)),
                                child: Text("& $earning/-"),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
