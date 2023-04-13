import 'package:cattle_guru_agent_app/models/Cart_model.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Add_customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Customer/All_customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Place_order_screen.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_AppBar.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescriptionScreen extends StatefulWidget {
  final String title;
  final String costperkg;
  final String weight;
  final String description;
  final String earnings;
  final String totalamt;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  const ProductDescriptionScreen({
    super.key,
    required this.title,
    required this.costperkg,
    required this.weight,
    required this.description,
    required this.totalamt,
    required this.earnings,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
  });

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  int _itemCount = 0;

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
        // print(productList[0]);
      });
    });
    print("pdhfdlkfdsjf");
    return productList;
  }

  Future<dynamic> placeorder(Crtprod cartModel) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .add(cartModel.toJson())
        .then((value) => Get.to(() => PlaceOrderScreen(
              customername: "",
            )))
        .catchError((error) => print("Failed to send details: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title, phonewhat: true),
      body: ListView(
        children: [
          imagecontainer([
            widget.image1,
            widget.image2,
            widget.image3,
            widget.image4,
          ], context),
          Padding(
            padding:
                EdgeInsets.all(SizeConfig(context).getProportionatePadding(10)),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
          quantitycard(context),
          ListTile(
            minLeadingWidth: 5,
            visualDensity: VisualDensity(vertical: -4),
            leading: Icon(Icons.verified_outlined),
            title: Text(
              widget.description,
            ),
          ),
          ListTile(
            minLeadingWidth: 5,
            visualDensity: VisualDensity(vertical: -4),
            leading: Icon(Icons.verified_outlined),
            title: Text(
              "Free Home Delivery every week",
            ),
          ),
          ListTile(
            minLeadingWidth: 5,
            visualDensity: VisualDensity(vertical: -4),
            leading: Icon(Icons.verified_outlined),
            title: Text(
              "Best Quality Guranteed",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: SizeConfig(context).getProportionateScreenHeight(50),
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
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You Earn",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              SizeConfig(context).getProportionatePadding(5.0)),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.green, width: 2.0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig(context)
                                    .getProportionateScreenWidth(8.0),
                                vertical: SizeConfig(context)
                                    .getProportionateScreenWidth(8.0)),
                            child: Text("₹ ${widget.earnings}/-"),
                          )),
                    ),
                    Text(
                      "Per Bag",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig(context).getProportionateScreenWidth(40),
                bottom: SizeConfig(context).getProportionateScreenWidth(10)),
            child: Row(
              children: [
                Text(
                  "Place Order",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          CustomButton(
            inptheight: 16,
            inptwidth: 1.2,
            inpttxt: "For new Customer",
            color: Colors.orange,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
            press: () async {
              //   readCartData();
              //   List<CartModel> productList = [];
              //   print("dsiofjdkl");
              //   print(FirebaseAuth.instance.currentUser!.uid);
              //   await FirebaseFirestore.instance
              //       .collection("users")
              //       .doc(FirebaseAuth.instance.currentUser?.uid)
              //       .collection("cart")
              //       .get()
              //       .then((querySnapshot) {
              //     querySnapshot.docs.forEach((product) {
              //       var _product = product.data();
              //       print(_product);
              //       productList.add(CartModel.fromJson(_product));
              //       // print(productList[0]);
              //     });
              //   });
              //   CartModel cartModel = CartModel(
              //     pincode: productList[0].pincode,
              //     district: productList[0].district,
              //     phonenum: productList[0].phonenum,
              //     customername: productList[0].customername,
              //     villagename: productList[0].villagename,
              //     crtprod: [
              //       Crtprod(
              //           description: widget.description,
              //           disprice: widget.totalamt,
              //           price: widget.totalamt,
              //           quantity: widget.weight,
              //           wt: widget.weight,
              //           image: "",
              //           name: widget.title),
              //     ],
              //   );
              //   placeorder(cartModel);
              //   Get.to(() => PlaceOrderScreen());
              if (_itemCount == 0) {
                Get.to(() => AddCustomerScreen(
                      image: widget.image1,
                      quantity: _itemCount.toString(),
                      price: widget.totalamt,
                      description: widget.description,
                      disprice: widget.totalamt,
                      wt: widget.weight,
                      name: widget.title,
                    ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Customer added SucessFully'),
                  duration: Duration(seconds: 3),
                ));
              }
            },
          ),
          SizedBox(
            height: SizeConfig(context).getProportionateScreenHeight(20),
          ),
          CustomButton(
            inptheight: 16,
            inptwidth: 1.2,
            inpttxt: "For Existing Customer",
            color: Colors.orange,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
            press: () async {
              Get.to(() => AllCustomerScreen(
                    image: widget.image1,
                    quantity: _itemCount.toString(),
                    price: widget.totalamt,
                    description: widget.description,
                    disprice: widget.totalamt,
                    wt: widget.weight,
                    name: widget.title,
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget quantitycard(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
      child: Container(
        height: SizeConfig(context).getProportionateScreenHeight(120),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth / 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.orange, width: 2.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig(context)
                                        .getProportionateScreenWidth(8.0),
                                    vertical: SizeConfig(context)
                                        .getProportionateScreenWidth(4.0)),
                                child: Text(
                                    "₹ ${double.parse(widget.costperkg) * _itemCount}/-"),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "₹${widget.costperkg} per kg",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weight",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.orange, width: 2.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig(context)
                                          .getProportionateScreenWidth(8.0),
                                      vertical: SizeConfig(context)
                                          .getProportionateScreenWidth(4.0)),
                                  child: Text(widget.weight == ""
                                      ? "00"
                                      : (double.parse(widget.weight) *
                                              _itemCount)
                                          .toString()),
                                )),
                          ),
                          Container(
                            child: Text(
                              "Kg",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig(context).getProportionateScreenWidth(140),
              height: SizeConfig(context).getProportionateScreenHeight(40),
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
                    _itemCount.toString(),
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
          ],
        ),
      ),
    );
  }

  var pages = ["a", "b", "c", "d"];

  Widget imagecontainer(List<String> image, BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight / 4,
      width: screenWidth,
      child: DefaultTabController(
        length: pages.length,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TabBarView(
                    children: [
                      Image.network(
                        image[0],
                        width: 9 * screenWidth / 10,
                      ),
                      Image.network(
                        image[1],
                        width: 9 * screenWidth / 10,
                      ),
                      Image.network(
                        image[2],
                        width: 9 * screenWidth / 10,
                      ),
                      Image.network(
                        image[3],
                        width: 9 * screenWidth / 10,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        SizeConfig(context).getProportionatePadding(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const TabPageSelector(
              selectedColor: kPrimaryColor,
              color: Colors.grey,
              borderStyle: BorderStyle.none,
            ),
          ],
        ),
      ),
    );
  }
}
