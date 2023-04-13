import 'package:cattle_guru_agent_app/models/Customer_details_model.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Place_order_screen.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_Customer_details.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';

class AllCustomerScreen extends StatefulWidget {
  final String image;
  final String quantity;
  final String price;
  final String description;
  final String disprice;
  final String wt;
  final String name;
  const AllCustomerScreen(
      {super.key,
      this.image = "",
      this.quantity = "",
      this.price = "",
      this.description = "",
      this.disprice = "",
      this.wt = "",
      this.name = ""});

  @override
  State<AllCustomerScreen> createState() => _AllCustomerScreenState();
}

class _AllCustomerScreenState extends State<AllCustomerScreen> {
  Future<List<CustomerDetails>> readCartData1() async {
    List<CustomerDetails> productList = [];
    print("dsiofjdkl");
    print(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("customerdetails")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(CustomerDetails.fromJson(_product));
      });
    });
    print("pdhfdlkfdsjf");
    print(productList[0]);
    return productList;
  }

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
          FutureBuilder<List<CustomerDetails>>(
              future: readCartData1(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  List<CustomerDetails> productList = snapshot.data ?? [];
                  print(productList);
                  return Expanded(
                      child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: productList.length,
                    itemBuilder: ((context, index) {
                      return DetailsCard(context, [
                        productList[index].name,
                        productList[index].phonenum,
                        productList[index].district
                      ]);
                    }),
                  ));
                } else {
                  return CircularProgressIndicator();
                }
              }),
          CustomButton(
            inptheight: 20,
            inptwidth: 1.25,
            inpttxt: "Continue",
            color: Colors.orange,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            press: () {},
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
                  child: ProfilePicture(
                      name: details[0], radius: 80, fontsize: 25),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
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
                    Get.to(() => PlaceOrderScreen(
                          customername: details[0],
                        ));
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
