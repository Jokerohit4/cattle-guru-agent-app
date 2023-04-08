import 'package:cattle_guru_agent_app/models/Earnings_model.dart';
import 'package:cattle_guru_agent_app/models/Order_model.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MonthEarningsScreen extends StatefulWidget {
  const MonthEarningsScreen({super.key});

  @override
  State<MonthEarningsScreen> createState() => _MonthEarningsScreenState();
}

class _MonthEarningsScreenState extends State<MonthEarningsScreen> {
  Future< List<OrdersModel>> getStarted_readData() async
    {
      List<OrdersModel> productList = [];
    // print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("orders")
        .doc("pendingorders")
        .collection("pendingorder")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(OrdersModel.fromJson(_product));
        print(productList);
      });
    });
    // print(productList);
    return productList;
    }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchcontroller = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange.shade50,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: const Text(
          "My March Earnings",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 20, vertical: screenHeight / 150),
              child: Row(
                children: const [
                  Text(
                    "My Earnings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (3.5) * (screenWidth / 5),
                  height: screenHeight / 18,
                  alignment: Alignment.center,
                  child: CustomInputField(
                    controller: searchcontroller,
                    hintText: "Search Name | Number",
                    sufwidget: Padding(
                      padding: EdgeInsets.only(right: screenWidth / 100, top: screenHeight/ 160, bottom: screenHeight/ 160, left: screenWidth/8),
                      child: Container(
                          width: screenWidth / 20,
                          height: screenHeight / 50,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.search,
                            size: 18,
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
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: FutureBuilder<List<OrdersModel>>(
              future: getStarted_readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<OrdersModel> productList = snapshot.data ?? [];
                return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: productList.length,
                          itemBuilder: ((context, index) {
                            return EarningDetails(
                              context,
                              "Gaurav Panwar",
                              productList[index].totalbags.toString(),
                              productList[index].orderval.toString(),
                              productList[index].myearning.toString(),
                              productList[index].orderno.toString(),
                              productList[index].date.toString()
                            );
                          }),
                        );
              }
              else
              {
                return CircularProgressIndicator();
              }
              }
            )
                  ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "My Total Earning",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    CustomButton(
                      inptheight: 20,
                      inptwidth: 5,
                      inpttxt: "5000/-",
                      color: Colors.orange,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      press: () {
                        // Get.to(() => EditBankDetailsScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            inptheight: 16,
            inptwidth: 1.25,
            inpttxt: "WithDraw Earnings",
            color: Colors.orange,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
            press: () {
              // Get.to(() => EditBankDetailsScreen());
            },
          ),
        ],
      ),
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
                                  border:
                                      Border.all(color: Colors.green, width: 2.0),
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
