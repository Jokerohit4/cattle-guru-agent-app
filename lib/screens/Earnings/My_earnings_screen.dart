import 'package:cattle_guru_agent_app/models/Earnings_model.dart';
import 'package:cattle_guru_agent_app/screens/Earnings/Month_earnings_screen.dart';
import 'package:cattle_guru_agent_app/screens/Earnings/withdraw_earnings_screen.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Phone_whatsapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEarningsScreen extends StatefulWidget {
  const MyEarningsScreen({super.key});

  @override
  State<MyEarningsScreen> createState() => _MyEarningsScreenState();
}

class _MyEarningsScreenState extends State<MyEarningsScreen> {
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
        backgroundColor: Colors.orange.shade50,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          "My Earnings",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: PhoneWhatsapp(),
          )
        ],
      ),
      body: Column(
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
                      inpttxt: "1344/-",
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
            inptheight: 18,
            inptwidth: 3,
            inpttxt: "Withdraw Earnings",
            color: Colors.orange,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            press: () {
              Get.to(() => WithdrawEarningsScreen());
            },
          ),
          SizedBox(
            height: screenHeight / 80,
          ),
          FutureBuilder<List<EarningsModel>>(
              future: getStarted_readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<EarningsModel> productList = snapshot.data ?? [];
                  return Container(
                    height: 9 * (screenHeight) / 15,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: productList.length,
                      itemBuilder: ((context, index) {
                        return EanringsCard(
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
              })
        ],
      ),
    );
  }

  Widget EanringsCard(
      BuildContext context, String month, String orders, String earnings) {
    return InkWell(
      onTap: (){
        Get.to(() => const MonthEarningsScreen());
      },
      child: Padding(
        padding:
            EdgeInsets.all(SizeConfig(context).getProportionateScreenWidth(8)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromRGBO(240, 214, 214, 0.5), width: 2.0)),
          child: ListTile(
            visualDensity: const VisualDensity(horizontal: -4),
            leading: const Icon(
              Icons.calendar_month,
              color: kPrimaryColor,
            ),
            title: Text(
              month,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Total Order",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig(context)
                                    .getProportionateScreenWidth(8.0),
                                vertical: SizeConfig(context)
                                    .getProportionateScreenWidth(4.0)),
                            child: Text(orders),
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Your Total earnings of Month",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
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
                            child: Text("& $earnings/-"),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
