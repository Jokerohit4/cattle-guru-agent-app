import 'dart:math';

import 'package:cattle_guru_agent_app/controllers/Customer_details_controller.dart';
import 'package:cattle_guru_agent_app/models/Cart_model.dart';
import 'package:cattle_guru_agent_app/models/Customer_details_model.dart';
import 'package:cattle_guru_agent_app/models/Customer_details_model.dart';
import 'package:cattle_guru_agent_app/models/Order_model.dart';
import 'package:cattle_guru_agent_app/models/Product_model.dart';
import 'package:cattle_guru_agent_app/screens/Details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Earnings/My_earnings_screen.dart';
import 'package:cattle_guru_agent_app/screens/Home_screen.dart';
import 'package:cattle_guru_agent_app/screens/Navigation_screen.dart';
import 'package:cattle_guru_agent_app/screens/Payment_option.dart';
import 'package:cattle_guru_agent_app/screens/Product_description_page.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlaceOrderScreen extends StatefulWidget {
  late int tabIndex;
   String customername;
  PlaceOrderScreen({super.key, this.tabIndex = 1, this.customername = ""});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final List<String> myitems = [
    'Sports',
  ];
  String? selectedValue = "";
  double sumearnings = 0.0;
  double totalorderval = 0.0;
  Future<List<Product>> getStarted_readData() async {
    List<Product> productList = [];
    // print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        // print(_product);
        productList.add(Product.fromJson(_product));
        print(productList);
      });
    });
    productList.forEach((element) {
      sumbags += int.parse(element.totalwt.toString());
      sumearnings += double.parse(element.earning.toString());
      totalorderval += double.parse(element.totalamt.toString());
    });
    // print(productList);
    return productList;
  }

  int p = 0;
  Future<List<Crtprod>> readCartData() async {
    List<Crtprod> productList = [];
    print("dsiofjdkl");
    print(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("cart")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(Crtprod.fromJson(_product));
      });
    });

    return productList;
  }

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

  String getCustomUniqueId() {
    const String pushChars =
        '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 64];
      now = (now / 64).floor();
    }
    if (now != 0) {
      print("Id should be unique");
    }
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random().nextDouble() * 64).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 8; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }

  Future<void> _showAlertDialog() async {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchcontroller = new TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 20,
                      vertical: screenHeight / 80),
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (3) * (screenWidth / 5),
                      height: screenHeight / 16,
                      child: CustomInputField(
                        controller: searchcontroller,
                        hintText: "Search Name | Number",
                        sufwidget: Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth / 60,
                              top: screenWidth / 60,
                              bottom: screenWidth / 60),
                          child: Container(
                              width: screenWidth / 20,
                              height: screenHeight / 30,
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
                          width: screenWidth / 10,
                          height: screenHeight / 20,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  inptheight: 20,
                  inptwidth: 1.25,
                  inpttxt: "Continue",
                  color: Colors.orange,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  press: () {
                    print(widget.customername);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool? secondvalue = false;

  Widget DetailsCard(BuildContext context, List<String> details) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight / 150, horizontal: screenWidth / 60),
      child: InkWell(
        onTap: () {
          widget.customername = details[0];
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(214, 200, 200, 0.25),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color.fromRGBO(214, 200, 200, 100),
            ),
          ),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
            selectedTileColor: kPrimaryColor,
            horizontalTitleGap: 1,
            leading: Container(
              height: SizeConfig(context).getProportionateScreenHeight(60),
              width: SizeConfig(context).getProportionateScreenWidth(60),
               child: ProfilePicture(
                      name: details[0], radius: 60, fontsize: 22),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headfield("User Name", details[0]),
                headfield("Phone No", details[1]),
                headfield("Village Name", details[2]),
              ],
            ),
            trailing: Checkbox(
              activeColor: kPrimaryColor,
              value: this.secondvalue,
              onChanged: (bool? value) {
                setState(() {
                  this.secondvalue = value;
                });
              },
            ),
          ),
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

  void changeTabIndex(int index) {
    setState(() {
      widget.tabIndex = index;
    });
  }

  int _itemCount = 0;
  double sum = 0.0;
  int sumbags = 0;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Crtprod>>(
        future: readCartData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<Crtprod> productList = snapshot.data ?? [];
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange.shade50,
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Place Order",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              body: GetBuilder<CustomerDetailsController>(
                init: CustomerDetailsController(),
                builder: (controller) {
                  return Form(
                    // key: controller.customerdetailskey,
                    child: ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth / 20,
                              top: screenWidth / 100,
                              bottom: screenWidth / 100,
                              right: screenWidth / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Customer Details",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight / 80),
                                child: CustomButton(
                                  inptheight: 16,
                                  inptwidth: 2.85,
                                  inpttxt: "Select Customer",
                                  color: Colors.orange,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                  press: () {
                                    _showAlertDialog();
                                    // Get.to(() => EnterDetailsScreen());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              texthead("Name*"),
                              CustomInputContainer(
                                  controller.namecontroller, "Name"),
                              texthead("Phone Number*"),
                              CustomInputContainer(
                                  controller.phonenum, "Mobile Number"),
                              texthead("Village Name*"),
                              CustomInputContainer(
                                  controller.villagenamecontroller,
                                  "Enter Village Name"),
                              texthead("District*"),
                              CustomInputContainer(
                                  controller.districtnamecontroller,
                                  "Select District Name"),
                              texthead("Pincode"),
                              CustomInputContainer(
                                  controller.pincodecontroller, "Pincode")
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
                                    hintText: "Enter Number"),
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
                                    hintText: "Enter Number"),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: screenHeight / 80),
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
                              CustomerDetails customerDetails = CustomerDetails(
                                  name: controller.namecontroller.text,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  phonenum: controller.phonenum.text,
                                  villagename:
                                      controller.villagenamecontroller.text,
                                  district:
                                      controller.districtnamecontroller.text,
                                  pincode: controller.pincodecontroller.text,
                                  buffaloes:
                                      controller.buffaloescontroller.text,
                                  cows: controller.cowcontroller.text);
                              controller.addUserInfo(customerDetails);
                              // Get.to(() => EnterDetailsScreen());
                            },
                          ),
                        ),
                        products(
                          context,
                          [khal, binola, churi, feed, others],
                          ["Khal", "Binloa", "Churi", "Feed", "Others"],
                          "Products",
                          [true, false, false, false, false],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, bottom: 10.0, top: 10.0),
                            width: MediaQuery.of(context).size.width - 10,
                            height: SizeConfig(context)
                                .getProportionateScreenHeight(
                                    240.0 * productList.length),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: productList.length,
                              itemBuilder: ((context, index) {
                                return ItemContainer(
                                    context,
                                    productList[index].image ?? "",
                                    productList[index].name ?? "",
                                    productList[index].description ?? "",
                                    productList[index].quantity ?? "",
                                    productList[index].price ?? "",
                                    productList[index].disprice ?? "",
                                    productList[index].wt ?? "");
                              }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig(context)
                              .getProportionatePadding(10.0)),
                          child: Container(
                            height: SizeConfig(context)
                                .getProportionateScreenHeight(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color.fromRGBO(240, 214, 214, 0.5)),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Total Bags",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig(context)
                                              .getProportionateScreenWidth(8.0),
                                          vertical: SizeConfig(context)
                                              .getProportionateScreenWidth(
                                                  4.0)),
                                      child:
                                          Text(productList.length.toString()),
                                    ),
                                  ),
                                  Text(
                                    "Order Value",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig(context)
                                              .getProportionateScreenWidth(8.0),
                                          vertical: SizeConfig(context)
                                              .getProportionateScreenWidth(
                                                  4.0)),
                                      child: Text("₹ $sum"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig(context)
                              .getProportionatePadding(10.0)),
                          child: Container(
                            height: SizeConfig(context)
                                .getProportionateScreenHeight(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color.fromRGBO(240, 214, 214, 0.5)),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "My Earnings on this Order",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig(context)
                                              .getProportionateScreenWidth(8.0),
                                          vertical: SizeConfig(context)
                                              .getProportionateScreenWidth(
                                                  4.0)),
                                      child: Text("₹ $sumearnings"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            inptheight: 16,
                            inptwidth: 1.15,
                            inpttxt: "Place Order",
                            color: Colors.orange,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                            press: () {
                              Get.to(() => PaymentScreen(
                                    orderval: totalorderval,
                                    myearning: sumearnings.toString(),
                                    totalbags: sumbags.toString(),
                                    orderid: getCustomUniqueId(),
                                    name: widget.customername,
                                    date: DateFormat("d/M/y")
                                        .format(DateTime.now())
                                        .toString(),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
          } else {
            return Scaffold(
                body: Center(child: Text("Waiting For Data Fetch")));
          }
        });
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

  Widget CustomInputContainer(
      TextEditingController textEditingController, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
      child: CustomInputField(
          controller: textEditingController, hintText: hintText),
    );
  }

  Widget products(BuildContext context, List<String> asset, List<String> text,
      String headtext, List<bool> selected) {
    return FutureBuilder<List<Product>>(
        future: getStarted_readData(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasData) {
            List<Product> productList = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Card(
                elevation: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(255, 255, 255, 1),
                            Color.fromRGBO(253, 248, 248, 1),
                          ]),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig(context)
                                .getProportionatePadding(10.0),
                            vertical: SizeConfig(context)
                                .getProportionatePadding(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              headtext,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              right: 0, left: 0, bottom: 10.0, top: 10.0),
                          width: MediaQuery.of(context).size.width - 10,
                          height: SizeConfig(context)
                              .getProportionateScreenHeight(120),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productList.length,
                            itemBuilder: ((context, index) {
                              return productitem(
                                  context,
                                  productList[index].image1,
                                  productList[index].fullname,
                                  selected[index],
                                  productList[index].totalwt,
                                  productList[index].costperkg,
                                  productList[index].description,
                                  productList[index].totalamt,
                                  productList[index].totalamt,
                                  productList[index].image1,
                                  productList[index].image2,
                                  productList[index].image3,
                                  productList[index].image4);
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget productitem(
      BuildContext context,
      String asset,
      String text,
      bool selected,
      String weight,
      String costperkg,
      String description,
      String total,
      String earng,
      String image1,
      String image2,
      String image3,
      String image4) {
    return InkWell(
      onHover: (value) {},
      onTap: () {
        Get.to(() => ProductDescriptionScreen(
              image1: image1,
              image2: image2,
              image3: image3,
              image4: image4,
              title: text,
              costperkg: costperkg,
              description: description,
              earnings: earng,
              weight: weight,
              totalamt: total,
            ));
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig(context).getProportionatePadding(20.0),
            right: SizeConfig(context).getProportionatePadding(20.0)),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(asset)),
                  border: Border.all(
                      color: selected == true ? kPrimaryColor : Colors.white)),
            ),
            Container(
              width: SizeConfig(context).getProportionateScreenWidth(100),
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ItemContainer(
      BuildContext context,
      String asset,
      String name,
      String description,
      String qnt,
      String cost,
      String distprice,
      String wt) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig(context).getProportionatePadding(40)),
      child: Card(
        elevation: 1.0,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 1),
                    Color.fromRGBO(253, 248, 248, 1),
                  ]),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: Image.network(
                  asset,
                  height: SizeConfig(context).getProportionateScreenHeight(140),
                  width: SizeConfig(context).getProportionateScreenWidth(140),
                ),
              ),
              Container(
                width: SizeConfig(context).getProportionateScreenWidth(200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width:
                          SizeConfig(context).getProportionateScreenWidth(200),
                      height:
                          SizeConfig(context).getProportionateScreenHeight(95),
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      width:
                          SizeConfig(context).getProportionateScreenWidth(140),
                      height:
                          SizeConfig(context).getProportionateScreenHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black45),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: new Icon(Icons.remove),
                              onPressed: () => setState(() => _itemCount--)),
                          Text(
                            (_itemCount + int.parse(qnt)).toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                          new IconButton(
                              icon: new Icon(Icons.add),
                              onPressed: () => setState(() => _itemCount++))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "₹ $distprice",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "₹ $cost",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Wt $wt kg",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
