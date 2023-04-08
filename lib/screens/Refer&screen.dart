import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReferScreen extends StatelessWidget {
  const ReferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            applogo,
          ),
          Text(
            "Refer & Earn",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          RowTile("Share app to your mitra"),
          RowTile("Your Mitra install app"),
          RowTile("Your Mitra first order delivered"),
          RowTile("You earn 100 rupee"),

          Text("Referral Code", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),

          Row(
            children: [
              
            ],
          )
        ],
      ),
    );
  }

  Widget RowTile(String intp) {
    return ListTile(
      leading: Icon(Icons.abc),
      title: Text(
        intp,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      ),
    );
  }
}
