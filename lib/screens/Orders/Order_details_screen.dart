import 'package:cattle_guru_agent_app/utils/Size_config.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Phone_whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          "Order Details",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: PhoneWhatsapp(),
          )
        ],
      ),
      body: ListView(
        children: [
          CompletedOrderCard(
            context,
            "Gaurav Panwar",
            "01",
            "1344",
            "50",
            "1234ABCDID",
            "12/03/2023",
          ),
          orderdetails(mylist, context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Payment mode-",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: SizeConfig(context).getProportionateScreenWidth(230),
                child: Text(
                    "COD or Online by you or Shared Payment link by Customer.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          Center(child: _build(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Need help?"),
              PhoneWhatsapp(h:0.75),
            ],
          )
        ],
      ),
    );
  }

  Widget orderdetails(List<Map<String, String>> items, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding:
              const EdgeInsets.only(right: 0, left: 0, bottom: 10.0, top: 00.0),
          width: MediaQuery.of(context).size.width - 10,
          height: SizeConfig(context).getProportionateScreenHeight(60) *
              items.length,
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
    );
  }
  int _currentStep = 0;
  List<Step> _steps = [
    Step(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              orderconfirmeddetails,
              height: 40,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Confirmed",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                'Sun, 23rd October',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
      state: StepState.indexed,
      content: SizedBox(height: 0),
    ),
    Step(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              orderreceiveddetails,
              height: 40,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Received",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                'Sun, 23rd October',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
      state: StepState.complete,
      content: SizedBox(height: 0),
    ),
    Step(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              earningsreciveddetails,
              height: 40,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Earnings Received",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                'Sun, 23rd October',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
      state: StepState.complete,
      content: SizedBox(height: 0),
    ),
  ];

  @override
  Widget _build(BuildContext context) {
    return Stepper(
      steps: _steps,
      type: StepperType.vertical,
      currentStep: _currentStep,
      onStepTapped: (value) {
        setState(() {
          if (_currentStep < _steps.length - 1) {
            _currentStep++;
          }
        });
      },
      onStepContinue: () {
        setState(() {
          if (_currentStep < _steps.length - 1) {
            _currentStep++;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_currentStep > 0) {
            _currentStep--;
          }
        });
      },
      controlsBuilder: (context, details) {
        return Container();
      },
    );
  }
}
