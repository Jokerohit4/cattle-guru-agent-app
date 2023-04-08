import 'dart:async';

import 'package:cattle_guru_agent_app/models/Order_model.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Order_details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Track_order_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderSucessfulScreen extends StatefulWidget {
  final String name;
  final String bags;
  final String orderid;
  final String orderval;
  final String date;
  final String earning;
  const OrderSucessfulScreen({super.key, required this.name, required this.bags, required this.orderid, required this.orderval, required this.date, required this.earning});

  @override
  State<OrderSucessfulScreen> createState() => _OrderSucessfulScreenState();
}

class _OrderSucessfulScreenState extends State<OrderSucessfulScreen> {
  List<OrdersModel> productList = [];
  Future<List<OrdersModel>> readData() async {
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
        print("djgdklfjdlkfjd");
        print(productList[0]);
      });
    });
    print(productList[0]);
    return productList;
  }

  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TrackOrderScreen(
            name: "Gaurav",
            bags: widget.bags,
            orderid: widget.orderid,
            orderval: widget.orderval,
            date: widget.date,
            earning: widget.earning,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/order_sucessful.png",
              width: 100,
              height: 100,
            ),
            Text(
              "Order Sucessful",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
