import 'package:cattle_guru_agent_app/models/Product_model.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_AppBar.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

   Future<List<Product>> getStarted_readData() async {
    List<Product> productList = [];
    print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(Product.fromJson(_product));
        print(productList[0]);
      });
    });
    print(productList);
    return productList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Place Order Screen", phonewhat: false),
      body: ListView(
        children: [
          products(
            context,
            [khal, binola, churi, feed, others],
            ["Khal", "Binloa", "Churi", "Feed", "Others"],
            "Products",
            [true, false, false, false, false],
          ),
          // ItemContainer(context, khal, "Khal",
          //     "Animal food cotton cake seeds...", "1", "500", "431", "50"),
          // ItemContainer(context, khal, "Khal",
          //     "Animal food cotton cake seeds...", "1", "500", "431", "50"),
          // ItemContainer(context, khal, "Khal",
          //     "Animal food cotton cake seeds...", "1", "500", "431", "50"),
        FutureBuilder<List<Product>>(
        future: getStarted_readData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<Product> productList = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, bottom: 10.0, top: 10.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: SizeConfig(context).getProportionateScreenHeight(
                      240.0 * productList.length),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: productList.length,
                    itemBuilder: ((context, index) {
                      return ItemContainer(
                          context,
                          productList[index].image1,
                          productList[index].fullname,
                          productList[index].description,
                          "0",
                          productList[index].costperkg,
                          productList[index].totalamt,
                          productList[index].totalwt);
                    }),
                  ),
                ),
              );
            }
            else
            {
              return CircularProgressIndicator();
            }
        }
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total Bags",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig(context)
                              .getProportionateScreenWidth(8.0),
                          vertical: SizeConfig(context)
                              .getProportionateScreenWidth(4.0)),
                      child: Text("₹ 50/-"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Per Bag",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Text(
              "Place Order",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              inptheight: 16,
              inptwidth: 1.15,
              inpttxt: "For New Customer",
              color: Colors.orange,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
              press: () {
                // Get.to(() => EnterDetailsScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              inptheight: 16,
              inptwidth: 1.15,
              inpttxt: "For Exisiting Customer",
              color: Colors.orange,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
              press: () {
                // Get.to(() => EnterDetailsScreen());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget products(BuildContext context, List<String> asset, List<String> text,
      String headtext, List<bool> selected) {
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
                    horizontal:
                        SizeConfig(context).getProportionatePadding(10.0),
                    vertical:
                        SizeConfig(context).getProportionatePadding(10.0)),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    productitem(context, asset[0], text[0], selected[0]),
                    productitem(context, asset[1], text[1], selected[1]),
                    productitem(context, asset[2], text[2], selected[2]),
                    productitem(context, asset[3], text[3], selected[3]),
                    productitem(context, asset[4], text[4], selected[4]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productitem(
      BuildContext context, String asset, String text, bool selected) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(asset)),
                border: Border.all(
                    color: selected == true ? kPrimaryColor : Colors.white)),
          ),
          Container(
            width: SizeConfig(context).getProportionateScreenWidth(50),
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
