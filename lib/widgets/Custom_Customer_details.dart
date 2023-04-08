import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:flutter/material.dart';

class CustomCustomerDetailsCard extends StatelessWidget {
  final List <String> details;
  final String icon;
  const CustomCustomerDetailsCard({super.key, required this.details, required this.icon});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenWidth / 30),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(214, 200, 200, 0.25),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromRGBO(214, 200, 200, 100),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth / 50),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                    ),
                    SizedBox(
                      height: screenHeight / 20,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headfield("User Name", "Gaurav Panwar"),
                    headfield("Phone No", "8149645538"),
                    headfield("Village Name", "Begampur Khatola.."),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      inptheight: 20,
                      inptwidth: 4,
                      inpttxt: "Place Order",
                      color: Colors.orange,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      press: () {
                        // Get.to(() => EditBankDetailsScreen());
                      },
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  Widget headfield(String head, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(
            val,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
