import 'package:cattle_guru_agent_app/controllers/Customer_details_controller.dart';
import 'package:cattle_guru_agent_app/models/Cart_model.dart';
import 'package:cattle_guru_agent_app/models/Customer_details_model.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Place_order_screen.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddCustomerScreen extends StatefulWidget {
  final String image;
  final String quantity;
  final String price;
  final String description;
  final String disprice;
  final String wt;
  final String name;
  const AddCustomerScreen(
      {super.key,
      this.image = "",
      this.quantity = "",
      this.price = "",
      this.description = "",
      this.disprice = "",
      this.wt = "",
      this.name = ""});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  Future<dynamic> addUserInfo(CustomerDetails customerDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("customerdetails")
        .doc(customerDetails.phonenum)
        .set(customerDetails.toJson())
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Customer added SucessFully'),
              duration: Duration(seconds: 3),
            )))
        .catchError((error) => print("Failed to send details: $error"));
  }

  Future<dynamic> addCartInfo(Crtprod customerDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(customerDetails.name)
        .set(customerDetails.toJson())
        .then((value) => Get.to(() => PlaceOrderScreen(
              customername: "",
            )))
        .catchError((error) => print("Failed to send details: $error"));
  }

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
          "Add Customer",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: GetBuilder<CustomerDetailsController>(
          init: CustomerDetailsController(),
          builder: (controller) {
            return Form(
              key: controller.customerdetailskey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth / 20,
                          top: screenHeight / 40,
                          bottom: screenHeight / 40),
                      child: Text(
                        "Customer Details",
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
                          texthead("Name*"),
                          CustomInputContainer(controller.namecontroller,
                              "Name", TextInputType.name),
                          texthead("Phone Number*"),
                          CustomInputContainer(controller.phonenum,
                              "Mobile Number", TextInputType.phone),
                          texthead("Village Name*"),
                          CustomInputContainer(controller.villagenamecontroller,
                              "Village", TextInputType.name),
                          texthead("District*"),
                          CustomInputContainer(
                              controller.districtnamecontroller,
                              "Select District",
                              TextInputType.name),
                          texthead("Pincode"),
                          CustomInputContainer(controller.pincodecontroller,
                              "Pincode", TextInputType.number)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 20,
                          vertical: screenHeight / 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          texthead("Buffaloes"),
                          Container(
                            width: screenWidth / 2,
                            child: CustomInputField(
                              controller: controller.buffaloescontroller,
                              hintText: "Enter Number",
                              textInputType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 20,
                          vertical: screenHeight / 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          texthead("Cows"),
                          Container(
                            width: screenWidth / 2,
                            child: CustomInputField(
                              controller: controller.cowcontroller,
                              hintText: "Enter Number",
                              textInputType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight / 80),
                      child: CustomButton(
                        inptheight: 16,
                        inptwidth: 1.2,
                        inpttxt: "Add Customer",
                        color: Colors.orange,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        press: () {
                          CustomerDetails customerDetails = CustomerDetails(
                              name: controller.namecontroller.text,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              phonenum: controller.phonenum.text,
                              villagename:
                                  controller.villagenamecontroller.text,
                              district: controller.districtnamecontroller.text,
                              pincode: controller.pincodecontroller.text,
                              buffaloes: controller.buffaloescontroller.text,
                              cows: controller.cowcontroller.text);
                          addUserInfo(customerDetails);
                          controller.buffaloescontroller.text = "";
                          controller.cowcontroller.text = "";
                          controller.namecontroller.text = "";
                          controller.phonenum.text = "";
                          controller.villagenamecontroller.text = "";
                          controller.districtnamecontroller.text = "";
                          controller.pincodecontroller.text = "";
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          verifiedtick,
                          height: 20,
                          width: 20,
                        ),
                        Text(
                          "New customer has been added sucessfully",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight / 80),
                      child: CustomButton(
                        inptheight: 16,
                        inptwidth: 1.2,
                        inpttxt: "Place Order",
                        color: Colors.orange,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        press: () async {
                          CustomerDetails customerDetails = CustomerDetails(
                              name: controller.namecontroller.text,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              phonenum: controller.phonenum.text,
                              villagename:
                                  controller.villagenamecontroller.text,
                              district: controller.districtnamecontroller.text,
                              pincode: controller.pincodecontroller.text,
                              buffaloes: controller.buffaloescontroller.text,
                              cows: controller.cowcontroller.text);
                          await addUserInfo(customerDetails);
                          Crtprod cartdetails = Crtprod(
                            image: widget.image,
                            quantity: widget.quantity,
                            price: widget.price,
                            name: widget.name,
                            description: widget.description,
                            disprice: widget.disprice,
                            wt: widget.wt
                          );
                          await addCartInfo(cartdetails);
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
