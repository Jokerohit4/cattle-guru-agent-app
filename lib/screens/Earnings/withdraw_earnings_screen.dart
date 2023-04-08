import 'package:cattle_guru_agent_app/models/Earnings_model.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WithdrawEarningsScreen extends StatefulWidget {
  const WithdrawEarningsScreen({super.key});

  @override
  State<WithdrawEarningsScreen> createState() => _WithdrawEarningsScreenState();
}

class _WithdrawEarningsScreenState extends State<WithdrawEarningsScreen> {
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: SizeConfig(context).getProportionateScreenHeight(200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
          // <-- SEE HERE
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Request Sent',
                    style: TextStyle(
                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: Colors.orange,))
                ],
          ),
          Column(
                children: [
                  Image.asset(
                    ordersucess,
                    color: Colors.green,
                    height: 80,
                    width: 80,
                  ),
                  const Text(
                    'Your request has been sent Sucessfully',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
          ),

          Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    inptheight: 22,
                    inptwidth: 5,
                    inpttxt: "Ok",
                    color: Colors.orange,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
          ),
        ]),
              ),
            ));
      },
    );
  }

  Future< List<EarningsModel>> getStarted_readData() async
    {
      List<EarningsModel> productList = [];
    // print("sdjkfhldskfhd");
    await FirebaseFirestore.instance
        .collection("users").doc(FirebaseAuth.instance.currentUser?.uid).collection("earnings")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((product) {
        var _product = product.data();
        print(_product);
        productList.add(EarningsModel.fromJson(_product));
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange.shade50,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "Withdraw Earnings",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      "My Total Earning",
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
          Padding(
            padding:  EdgeInsets.only(left:20.0,top: 10.0),
            child: Text(
              "Available to withdraw",
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(240, 214, 214, 0.1),
                      Color.fromRGBO(240, 214, 214, 0.2),
                      Color.fromRGBO(240, 214, 214, 0.3),
                    ]),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey,width: 0.25)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.calendar_month_rounded,
                        color: kPrimaryColor,
                      ),
                      title: Text(
                        "May's  Earnings",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Container(
                        width: SizeConfig(context).getProportionateScreenWidth(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.orange, width: 2.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig(context)
                                        .getProportionateScreenWidth(8.0),
                                    vertical: SizeConfig(context)
                                        .getProportionateScreenWidth(4.0)),
                                child: Text("₹ 2004/-"),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      inptheight: 18,
                      inptwidth: 3,
                      inpttxt: "Withdraw now",
                      color: Colors.orange,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                      press: () {
                        _showAlertDialog();
                        // Get.to(() => SelectAppLangScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (20.0),vertical: SizeConfig(context).getProportionatePadding(10.0)),
            child: Text(
              "Past Transactions",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromRGBO(240, 214, 214, 0.5)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 252, 246, 237),
                        Color.fromARGB(255, 255, 240, 218),
                      ])),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Total order",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Earnings received",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                     FutureBuilder<List<EarningsModel>>(
              future: getStarted_readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<EarningsModel> productList = snapshot.data ?? [];
                  print(productList[0].totalorder);
                  return Container(
                    height: SizeConfig(context).getProportionateScreenHeight(80),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: productList.length,
                      itemBuilder: ((context, index) {
                        return pasttransactions(
                          context,
                          productList[index].month.toString(),
                          productList[index].totalorder.toString(),
                          productList[index].monthearnings.toString()
                        );
                      }),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
                   
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget pasttransactions(BuildContext context, String month, String totalorder,
      String earningrecived) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConfig(context).getProportionateScreenWidth(80),
            child: Text(
              month,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: SizeConfig(context).getProportionateScreenWidth(80),
            child: Text(
              totalorder,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: SizeConfig(context).getProportionateScreenWidth(100),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 2.0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          SizeConfig(context).getProportionateScreenWidth(8.0),
                      vertical:
                          SizeConfig(context).getProportionateScreenWidth(4.0),
                    ),
                    child: Text("₹ $earningrecived/-"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig(context).getProportionatePadding(10.0)),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
