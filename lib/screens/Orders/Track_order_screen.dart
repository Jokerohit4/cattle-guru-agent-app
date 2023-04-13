import 'package:cattle_guru_agent_app/screens/Home_screen.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_AppBar.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_status_tracker.dart';
import 'package:cattle_guru_agent_app/widgets/Order_tracker_widget.dart';
import 'package:cattle_guru_agent_app/widgets/Phone_whatsapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_tracker/order_tracker.dart';

class TrackOrderScreen extends StatefulWidget {
  final String name;
  final String bags;
  final String orderval;
  final String earning;
  final String orderid;
  final String date;
  const TrackOrderScreen(
      {super.key,
      this.name = "",
      this.bags = "",
      this.orderval = "",
      this.earning = "",
      this.orderid = "",
      this.date = ""});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  List<Map<String, String>> mylist = [
    {
      "item": "Khal",
      "count": "03",
    },
    {
      "item": "Binbola",
      "count": "0",
    },
    {
      "item": "Cattle Feed",
      "count": "0",
    },
    {
      "item": "Churi",
      "count": "0",
    },
    {
      "item": "Total Bags",
      "count": "03",
    },
  ];

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
    }).then((value) => Get.off(() => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(title: 'Track Order Screen', phonewhat: true,),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CompletedOrderCard(
              context,
              "Gaurav Panwar",
              widget.bags,
              widget.orderval,
              widget.earning,
              widget.orderid,
              widget.date,
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth / 10),
              child: Row(
                children: [
                  Text(
                    "Order Status",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            MyStatusTracker(),
            Padding(
              padding: EdgeInsets.only(left: screenWidth / 10),
              child: Row(
                children: [
                  Text(
                    "Order Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            orderdetails(mylist),
            CustomButton(
              inptheight: 16,
              inptwidth: 1.15,
              inpttxt: "Cancel Order",
              color: Colors.orange,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              press: () {
                deletedata(widget.orderid);
                // Get.to(() => EditBankDetailsScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget CompletedOrderCard(BuildContext context, String name, String bags,
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
                        ),
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
                            ),
                          ),
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

  Widget orderdetails(List<Map<String, String>> items) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding:
              const EdgeInsets.only(right: 0, left: 0, bottom: 10.0, top: 00.0),
          width: MediaQuery.of(context).size.width - 10,
          height: SizeConfig(context).getProportionateScreenHeight(200),
          color: Colors.white,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: EdgeInsets.all(
                    SizeConfig(context).getProportionatePadding(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width:
                          SizeConfig(context).getProportionateScreenWidth(100),
                      child: Text(
                        items[index]["item"].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    items[index]["count"].toString() != "0"
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig(context)
                                      .getProportionatePadding(10.0),
                                  horizontal: SizeConfig(context)
                                      .getProportionatePadding(10.0)),
                              child: Text(items[index]["count"].toString()),
                            ))
                        : Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig(context)
                                      .getProportionateScreenWidth(8.0),
                                  vertical: SizeConfig(context)
                                      .getProportionateScreenWidth(4.0)),
                              child: Text(items[index]["count"].toString()),
                            )),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget OrderStatusWidget() {
    return Row(
      children: [],
    );
  }

  Widget CustomListTile(
      BuildContext context, String asset, String status, String datetime) {
    return ListTile(
      leading: Image.asset(asset),
      title: Text(status),
      subtitle: Text(datetime),
    );
  }
}
