import 'package:cattle_guru_agent_app/models/Order_model.dart';
import 'package:cattle_guru_agent_app/screens/Details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Earnings/My_earnings_screen.dart';
import 'package:cattle_guru_agent_app/screens/Home_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Order_details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Order_sucessful_screen.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String orderid;
  final double orderval;
  final String name;
  final String totalbags;
  final String date;
  final String myearning;
  late int tabIndex;
  PaymentScreen(
      {super.key,
      this.tabIndex = 0,
      this.orderid = "",
      this.orderval = 0,
      this.name = '',
      this.totalbags = "",
      this.date = "",
      this.myearning = ""});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _razorpay = Razorpay();

  void initState() {
    print(widget.date);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSucess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSucess(PaymentSuccessResponse response) async {
    print("Payment Sucess");
    Future<dynamic> addUserInfo(OrdersModel orderDetails) {
      print("djflksd");
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("orders")
          .doc("pendingorders")
          .collection("pendingorder")
          .doc(widget.orderid)
          .set(orderDetails.toJson())
          .then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("cart")
                .get()
                .then((querySnapshot) {
              for (DocumentSnapshot doc in querySnapshot.docs) {
                doc.reference.delete();
              }
            }).catchError((error) => print("Failed to send details: $error"));
          })
          .then((value) => Get.off(() => OrderSucessfulScreen(
                bags: widget.totalbags,
                date: widget.date,
                earning: widget.myearning,
                name: widget.name,
                orderid: widget.orderid,
                orderval: widget.orderval.toString(),
              )))
          .catchError((error) => print("Failed to send details: $error"));
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Retry Payment");
    Get.off(() => PaymentScreen(
          totalbags: widget.totalbags,
          date: widget.date,
          myearning: widget.myearning,
          name: widget.name,
          orderid: widget.orderid,
          orderval: widget.orderval,
        ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("");
  }

  Future<dynamic> addUserInfo(OrdersModel orderDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("orders")
        .doc("pendingorders")
        .collection("pendingorder")
        .doc(widget.orderid)
        .set(orderDetails.toJson())
        .then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("cart")
              .get()
              .then((querySnapshot) {
            for (DocumentSnapshot doc in querySnapshot.docs) {
              doc.reference.delete();
            }
          }).catchError((error) => print("Failed to send details: $error"));
        })
        .then((value) => Get.off(() => OrderSucessfulScreen(
              bags: widget.totalbags,
              date: widget.date,
              earning: widget.myearning,
              name: widget.name,
              orderid: widget.orderid,
              orderval: widget.orderval.toString(),
            )))
        .catchError((error) => print("Failed to send details: $error"));
  }

  void changeTabIndex(int index) {
    setState(() {
      widget.tabIndex = index;
    });
  }

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
          "Payment Option",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: IndexedStack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Image.asset(
              payonline,
              width: screenWidth / 2,
            ),
            CustomButton(
              inptheight: 16,
              inptwidth: 1.2,
              inpttxt: "Pay Online",
              color: Colors.orange,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
              press: () {
                const total = 1;
                var name;
                var phonenumber;
                var ordervalu = widget.orderval;
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get()
                    .then((snapshot) {
                  name = snapshot.data();
                  print(name["phonenumber"]);
                  phonenumber = name["phonenumber"];
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection("enterdetails")
                    .get()
                    .then((snapshot) {
                  snapshot.docs.forEach((product) {
                    var _product = product.data();
                    name = _product["name"];
                    print(name);
                  });
                });
                print(widget.orderval);
                const description = "Payment for the order through online";
                var options = {
                  'key': 'rzp_live_hUk8LTeESrQ6lL',
                  'amount': ordervalu * 100.0,
                  'name': name,
                  'description': description,
                  'prefill': {
                    'contact': phonenumber,
                    'email': 'cattleguru2022@gmail.com'
                  }
                };

                try {
                  _razorpay.open(options);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
            Image.asset(
              paycash,
              width: screenWidth / 2,
            ),
            CustomButton(
              inptheight: 16,
              inptwidth: 1.2,
              inpttxt: "Pay Cash",
              color: Colors.orange,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
              press: () {
                print("djflksd");
                OrdersModel orderdetails = OrdersModel(
                    totalbags: widget.totalbags,
                    date: widget.date,
                    myearning: widget.myearning,
                    orderno: widget.orderid,
                    orderval: widget.orderval.toString(),
                    items: Items(
                        totalBags: "",
                        binola: "",
                        cattleFeed: "",
                        churi: "",
                        khal: ""));
                addUserInfo(orderdetails);
              },
            ),
          ]),
          HomeScreen(),
          HomeScreen(),
          MyEarningsScreen(),
        ],
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
}
