import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:flutter/material.dart';

class PayingCustomerScreen extends StatefulWidget {
  const PayingCustomerScreen({super.key});

  @override
  State<PayingCustomerScreen> createState() =>
      _PayingCustomerScreenState();
}

class _PayingCustomerScreenState extends State<PayingCustomerScreen> {
  TextEditingController searchcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange.shade50,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "Potential Customer",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 20, vertical: screenHeight / 80),
              child: Padding(
                padding: EdgeInsets.all(screenHeight / 80),
                child: Text(
                  "Customer Details",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (3.5) * (screenWidth / 5),
                  child: CustomInputField(
                    controller: searchcontroller,
                    hintText: "Search Name | Number",
                    sufwidget: Padding(
                      padding: EdgeInsets.only(right: screenWidth / 100),
                      child: Container(
                          width: screenWidth / 10,
                          height: screenHeight / 20,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth / 100),
                  child: Container(
                      width: screenWidth / 8,
                      height: screenHeight / 15,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                DetailsCard(
                  context,
                  ["Gaurav Panwar", "8149645538", "Begampur Khatola.."],
                ),
                DetailsCard(
                  context,
                  ["Akash Headov", "8149645538", "Begampur "],
                ),
                DetailsCard(
                  context,
                  ["OnKar W", "8249525540", "Haryana"],
                ),
                DetailsCard(
                  context,
                  ["Prandeep G", "8149645538", "Khatola"],
                ),
                DetailsCard(
                  context,
                  ["Prandeep G", "8149645538", "Khatola"],
                ),
                DetailsCard(
                  context,
                  ["Prandeep G", "8149645538", "Khatola"],
                ),
                DetailsCard(
                  context,
                  ["Prandeep G", "8149645538", "Khatola"],
                ),
              ],
            ),
          ),
          CustomButton(
                  inptheight: 20,
                  inptwidth: 1.25,
                  inpttxt: "Continue",
                  color: Colors.orange,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  press: () {
                    // Get.to(() => EditBankDetailsScreen());
                  },
                ),
        ],
      ),
    );
  }

  Widget DetailsCard(BuildContext context, List<String> details) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 30, vertical: screenHeight / 150),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(214, 200, 200, 0.25),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromRGBO(214, 200, 200, 100),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth / 50),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
                SizedBox(
                  height: screenHeight / 20,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headfield("User Name", details[0]),
                headfield("Phone No", details[1]),
                headfield("Village Name", details[2]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black87,
                ),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  inptheight: 20,
                  inptwidth: 4,
                  inpttxt: "Place Order",
                  color: Colors.orange,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  press: () {
                    // Get.to(() => EditBankDetailsScreen());
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget headfield(String head, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Container(
            width: 150,
            child: Text(
              val,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
