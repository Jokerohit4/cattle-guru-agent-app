import 'package:cattle_guru_agent_app/models/Bank_details_model.dart';
import 'package:cattle_guru_agent_app/screens/Auth/phone_screen.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Add_customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Customer/All_customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Paying_customer.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Potential_Customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Earnings/My_earnings_screen.dart';
import 'package:cattle_guru_agent_app/screens/Earnings/withdraw_earnings_screen.dart';
import 'package:cattle_guru_agent_app/screens/Edit_bank_details.dart';
import 'package:cattle_guru_agent_app/screens/My_profile_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Orders_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Place_order_screen.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
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
      body: ListView(
        children: [
          CstmListTile("My Profile", () {
            Get.to(() => MyProfileScreen());
          }),
          CstmListTile("Transfer Earnings to Bank", () {
            Get.to(() => WithdrawEarningsScreen());
          }),
          CstmListTile("My Earnings", () {
            Get.to(() => MyEarningsScreen());
          }),
          CstmListTile("Bank Details", () {
            Get.to(() => EditBankDetailsScreen());
          }),
          CstmListTile("Language", () {
            Get.to(() => MyProfileScreen());
          }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(
              thickness: 5.0,
              color: Colors.grey.shade300,
            ),
          ),
          CstmListTile("Order for New Customer", () {
            Get.to(() => PlaceOrderScreen());
          }),
          CstmListTile("Order for existing Customer", () {
            Get.to(() => PlaceOrderScreen());
          }),
          CstmListTile("Past Orders", () {
            Get.to(() => OrderScreen());
          }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(
              thickness: 5.0,
              color: Colors.grey.shade300,
            ),
          ),
          CstmListTile("Add new Customer", () {
            Get.to(() => AddCustomerScreen());
          }),
          CstmListTile("Paying Customer", () {
            Get.to(() => PayingCustomerScreen());
          }),
          CstmListTile("Potential Earnings", () {
            Get.to(() => PotentialCustomerScreen());
          }),
          CstmListTile("All Customer", () {
            Get.to(() => AllCustomerScreen());
          }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(
              thickness: 5.0,
              color: Colors.grey.shade300,
            ),
          ),
          CstmListTile("Terms & Conditions", () {
            Get.to(() => MyProfileScreen());
          }),
          CstmListTile("Privacy Policy", () {
            Get.to(() => MyProfileScreen());
          }),
          CstmListTile("Rate & Feeback", () {
            Get.to(() => MyProfileScreen());
          }),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            inptheight: 16,
            inptwidth: 1.2,
            inpttxt: "Share",
            color: Colors.orange,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
            press: () {
              // Get.to(() => EnterDetailsScreen());
            },
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            inptheight: 16,
            inptwidth: 1.2,
            inpttxt: "Logout",
            color: Colors.orange,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
            press: () async {
              await FirebaseAuth.instance.signOut();
              Get.to(() => PhoneScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget CstmListTile(String inptxt, Function press) {
    return InkWell(
      onTap: press as Function()?,
      child: ListTile(
        leading: Icon(
          Icons.photo_outlined,
          color: Colors.orange,
        ),
        title: Text(
          inptxt,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 16,
        ),
      ),
    );
  }
}
