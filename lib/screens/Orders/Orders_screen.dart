import 'package:cattle_guru_agent_app/models/Order_model.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Order_details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Track_order_screen.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<List<OrdersModel>> getStarted_readData() async {
    List<OrdersModel> productList = [];
    print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("orders")
        .doc("completedorders")
        .collection("compeletedorder")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(OrdersModel.fromJson(_product));
        print(productList[0].items?.totalBags);
      });
    });
    print(productList);
    return productList;
  }

  Future<List<OrdersModel>> readData() async {
    List<OrdersModel> productList = [];
    print("sdjkfhldskfhd");
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
        print(productList[0].items?.totalBags);
      });
    });
    print(productList);
    return productList;
  }

  deletedata(String orderno) async {
    print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("orders")
        .doc("pendingorders")
        .collection("pendingorder")
        .where("orderno", isEqualTo: orderno)
        .get()
        .then((querySnapshot) {
      for (DocumentSnapshot doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    }).then((value) => Get.to(() => OrderDetailsScreen()));
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange.shade50,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text(
            "All Orders",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: kPrimaryColor,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Pending Orders',
              ),
              Tab(text: 'Completed Orders'),
            ],
          ),
          toolbarHeight: 50,
        ),
        body: TabBarView(controller: _tabController, children: [
          pendingorderTab(),
          CompletedOrderTab(),
        ]));
  }

  Widget CompletedOrderTab() {
    return FutureBuilder<List<OrdersModel>>(
        future: getStarted_readData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<OrdersModel> productList = snapshot.data ?? [];
            print(productList);
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: productList.length,
              itemBuilder: ((context, index) {
                return CompletedOrderCard(
                    context,
                    "Gaurav Panwar",
                    productList[index].totalbags.toString(),
                    productList[index].orderval.toString(),
                    productList[index].myearning.toString(),
                    productList[index].orderno.toString(),
                    productList[index].date.toString());
              }),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget pendingorderTab() {
    return FutureBuilder<List<OrdersModel>>(
        future: readData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<OrdersModel> productList = snapshot.data ?? [];
            print(productList);
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: productList.length,
              itemBuilder: ((context, index) {
                return pendingorderCard(
                    context,
                    "Gaurav Panwar",
                    productList[index].totalbags.toString(),
                    productList[index].orderval.toString(),
                    productList[index].myearning.toString(),
                    productList[index].orderno.toString(),
                    productList[index].date.toString());
              }),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget pendingorderCard(BuildContext context, String name, String bags,
      String orderval, String earning, String orderid, String date) {
    return InkWell(
      onTap: () {
        Get.to(() => TrackOrderScreen(
              name: name,
              bags: bags,
              orderval: orderval,
              orderid: orderid,
              date: date,
              earning: earning,
            ));
      },
      child: Padding(
        padding: EdgeInsets.all(
            SizeConfig(context).getProportionateScreenHeight(10)),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              orderid,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
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
                            Text(
                              date,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomButton(
                      inptheight: 18,
                      inptwidth: 3,
                      inpttxt: "Cancel Order",
                      color: Colors.orange,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                      press: () {
                        deletedata(orderid);
                        // Get.to(() => SelectAppLangScreen());
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          SizeConfig(context).getProportionatePadding(10)),
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
                      horizontal:
                          SizeConfig(context).getProportionatePadding(5)),
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
      ),
    );
  }

  Widget CompletedOrderCard(BuildContext context, String name, String bags,
      String orderval, String earning, String orderid, String date) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderDetailsScreen());
      },
      child: Padding(
        padding: EdgeInsets.all(
            SizeConfig(context).getProportionateScreenHeight(10)),
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
                      vertical:
                          SizeConfig(context).getProportionatePadding(10)),
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
                      horizontal:
                          SizeConfig(context).getProportionatePadding(5)),
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
      ),
    );
  }
}
