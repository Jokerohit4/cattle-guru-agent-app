import 'dart:io';

import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneWhatsapp extends StatefulWidget {
  final double h;
  const PhoneWhatsapp({super.key, this.h = 1.0});

  @override
  State<PhoneWhatsapp> createState() => _PhoneWhatsappState();
}

class _PhoneWhatsappState extends State<PhoneWhatsapp> {
  openwhatsapp() async {
    var whatsapp = "+918143957028";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp  is not installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp is not installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0* widget.h),
          child: InkWell(
            onTap: () async {
              launch('tel://8143957028');
              await FlutterPhoneDirectCaller.callNumber("+918143957028");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10.0*widget.h, horizontal: 15.0*widget.h),
                child: Image.asset(
                  phone,
                  height: (20 * widget.h),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0* widget.h),
          child: InkWell(
            onTap: () {
              openwhatsapp();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green)),
              child: Padding(
                padding:  EdgeInsets.symmetric(
                    vertical: 10.0*widget.h, horizontal: 15.0*widget.h),
                child: Image.asset(
                  whatsapp,
                  height: (20 * widget.h),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
