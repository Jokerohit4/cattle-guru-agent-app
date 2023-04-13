import 'dart:ffi';
import 'dart:io';
import 'package:cattle_guru_agent_app/models/Product_model.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Add_customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Customer/All_customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Paying_customer.dart';
import 'package:cattle_guru_agent_app/screens/Customer/Potential_Customer_screen.dart';
import 'package:cattle_guru_agent_app/screens/Menu_screen.dart';
import 'package:cattle_guru_agent_app/screens/Navigation_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Orders_screen.dart';
import 'package:cattle_guru_agent_app/screens/Product_description_page.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_AppBar.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cattle_guru_agent_app/widgets/Phone_whatsapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/Custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List<String> productslist = [];
  Future<void> retrieveFiles() async {
    final ref = FirebaseStorage.instance.ref().child('products');
    print(ref);
    ListResult result = await ref.listAll();
    result.items.forEach((Reference ref) async {
      String downloadURL = await ref.getDownloadURL();
      productslist.add(downloadURL);
      print(downloadURL);
    });
  }

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
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController refralcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const MenuScreen());
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: PhoneWhatsapp(),
          )
        ],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.shade200)),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "My January Earning",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  CustomButton(
                    inptheight: 22,
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
        orderscard(
            context,
            [fornewcustomer, forexistingcustomer, pastorder],
            [
              "Order for new customer",
              "Order for existing customer",
              "Past orders"
            ],
            "Orders",
            [true, false, false],
            [
              () {
                Get.to(() => const AddCustomerScreen());
              },
              () {
                Get.to(() => const PotentialCustomerScreen());
              },
              () {
                Get.to(() => const OrderScreen());
              }
            ]),
        orderscard(
            context,
            [newcustomer, payingcustomer, allcustomers],
            ["Add new Customer", "Paying Customer", "All Customers"],
            "Customers",
            [true, false, false],
            [
              () {
                Get.to(() => const AddCustomerScreen());
              },
              () {
                Get.to(() => const PayingCustomerScreen());
              },
              () {
                Get.to(() => const AllCustomerScreen());
              }
            ]),
        const Text(
          "Know more about Pashu Mitra",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        VideoContainer(context),
        products(
            context,
            [khal, binola, churi, feed, others],
            ["Khal", "Binloa", "Churi", "Feed", "Others"],
            "Products",
            [true, false, false, false, false],
            ["Khal", "Binloa", "Churi", "Feed", "Others"]),
        Customoffers(context, "Custom offers"),
        InkWell(
          onTap: () {
            Get.to(() => NavigationScreen(
                  tabIndex: 3,
                ));
          },
          child: earningscard(
              context,
              [
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
                earnings,
              ],
              [
                "5000/-\n Dec",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
                "5000/-\n Sep",
              ],
              "My Earnings",
              [
                true,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false
              ]),
        ),
        Customoffers(context, "My offers"),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(240, 214, 214, 0.1),
                      Color.fromRGBO(240, 214, 214, 0.2),
                      Color.fromRGBO(240, 214, 214, 0.3),
                    ]),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey, width: 0.25)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Refer & Earn",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: SizeConfig(context)
                            .getProportionateScreenWidth(200),
                        child: CustomInputField(
                            controller: refralcontroller,
                            hintText: " Your Referral Code"),
                      ),
                      CustomButton(
                        inptheight: 16,
                        inptwidth: 5,
                        inpttxt: "Share",
                        color: Colors.orange,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        press: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget orderscard(BuildContext context, List<String> asset, List<String> text,
      String headtext, List<bool> selected, List<Function> fun) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(240, 214, 214, 0.1),
                  Color.fromRGBO(240, 214, 214, 0.2),
                  Color.fromRGBO(240, 214, 214, 0.3),
                ]),
            border: Border.all(width: 0.25, color: Colors.grey),
            boxShadow: [
              const BoxShadow(color: Colors.white, offset: Offset(-3.0, 3.0)),
            ],
            borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 7.0, bottom: 2.0),
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
                      style: const TextStyle(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    carditem(context, asset[0], text[0], selected[0], fun[0]),
                    carditem(context, asset[1], text[1], selected[1], fun[1]),
                    carditem(context, asset[2], text[2], selected[2], fun[2]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carditem(BuildContext context, String asset, String text,
      bool selected, Function press) {
    return InkWell(
      onTap: press as void Function()?,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: selected == true ? kPrimaryColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                    color: selected == false ? kPrimaryColor : Colors.white)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                asset,
                color: selected == true ? Colors.white : Colors.black,
              ),
            ),
          ),
          Container(
            width: SizeConfig(context).getProportionateScreenWidth(120),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget VideoContainer(BuildContext context) {
    return Container(
      height: SizeConfig(context).getProportionateScreenHeight(140),
      child: ListView(scrollDirection: Axis.horizontal, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig(context).getProportionateScreenHeight(100),
                width: SizeConfig(context).getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Image.asset(applogo),
              ),
              const Text(
                "Video name one",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig(context).getProportionateScreenHeight(100),
                width: SizeConfig(context).getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Image.asset(applogo),
              ),
              const Text(
                "Video name one",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig(context).getProportionateScreenHeight(100),
                width: SizeConfig(context).getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Image.asset(applogo),
              ),
              const Text(
                "Video name one",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig(context).getProportionateScreenHeight(100),
                width: SizeConfig(context).getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Image.asset(applogo),
              ),
              const Text(
                "Video name one",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig(context).getProportionateScreenHeight(100),
                width: SizeConfig(context).getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Image.asset(applogo),
              ),
              const Text(
                "Video name one",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 13),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget products(BuildContext context, List<String> asset, List<String> text,
      String headtext, List<bool> selected, List<String> title) {
    return FutureBuilder<List<Product>>(
        future: getStarted_readData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<Product> productList = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Card(
                elevation: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
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
                              style: const TextStyle(
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
            return const CircularProgressIndicator();
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
    String image4,
  ) {
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
                style: const TextStyle(
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

  var pages = ["a", "b", "c", "d"];

  Widget Customoffers(BuildContext context, String title) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 20, vertical: screenWidth / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            Container(
              height: screenHeight / 5,
              width: screenWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(242, 167, 76, 100)),
                  borderRadius: BorderRadius.circular(10)),
              child: DefaultTabController(
                length: pages.length,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          TabBarView(
                            children: [
                              Image.asset(
                                khal,
                                width: 9 * screenWidth / 10,
                              ),
                              Image.asset(
                                khal,
                                width: 9 * screenWidth / 10,
                              ),
                              Image.asset(
                                khal,
                                width: 9 * screenWidth / 10,
                              ),
                              Image.asset(
                                khal,
                                width: 9 * screenWidth / 10,
                              ),
                            ],
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
            ),
          ],
        ),
      ),
    );
  }

  Widget earningscard(BuildContext context, List<String> asset,
      List<String> text, String headtext, List<bool> selected) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 1.0,
        child: Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
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
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      earningitem(context, asset[0], text[0], selected[0]),
                      earningitem(context, asset[1], text[1], selected[1]),
                      earningitem(context, asset[2], text[2], selected[2]),
                      earningitem(context, asset[3], text[3], selected[3]),
                      earningitem(context, asset[4], text[4], selected[4]),
                      earningitem(context, asset[5], text[5], selected[5]),
                      earningitem(context, asset[6], text[6], selected[6]),
                      earningitem(context, asset[7], text[7], selected[7]),
                      earningitem(context, asset[8], text[8], selected[8]),
                      earningitem(context, asset[9], text[9], selected[9]),
                      earningitem(context, asset[10], text[10], selected[10]),
                      earningitem(context, asset[11], text[11], selected[11]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget earningitem(
      BuildContext context, String asset, String text, bool selected) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: selected == true ? kPrimaryColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                    color: selected == false ? kPrimaryColor : Colors.white)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                asset,
                color: selected == true ? Colors.white : Colors.black,
              ),
            ),
          ),
          Container(
            width: SizeConfig(context).getProportionateScreenWidth(60),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myoffers(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 20, vertical: screenWidth / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Custom offers",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            Container(
              height: screenHeight / 5,
              width: screenWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(242, 167, 76, 100)),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image_outlined,
                    color: Color.fromRGBO(242, 167, 76, 100),
                    size: 30,
                  ),
                  const Text(
                    "image",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
