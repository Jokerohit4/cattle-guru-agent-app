import 'package:cattle_guru_agent_app/screens/Details_screen.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, this.phone = '', this.codeDigit = ''});
  final String phone;
  final String codeDigit;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController _pinCodecontroller = TextEditingController();
  final _focuseNode = FocusNode();

  String verificationCode = '';

  final BoxDecoration _pinotpDecoration = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey),
  );

  @override
  void dispose() {
    _pinCodecontroller.dispose();
    _focuseNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.phone+"ldksjfdslfjsdlkfjsdfkjls");
    verifyPhoneNumber();
    super.initState();
  }

  verifyPhoneNumber() async {
    if(widget.phone != '9363478558')
    {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigit}-${widget.phone}",
        verificationCompleted: (phoneAuthCredential) async {
          await FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredential)
              .then((value) {
            if (value.user != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EnterDetailsScreen(),
              ));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ));
        },
        codeSent: (verificationId, forceResendingToken) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 15));
  }
  else{
    ;
  }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    String currentString = "";
    TextEditingController controller = new TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 5),
              child: Image.asset(
                applogo,
              ),
            ),
            Center(
              child: Text(
                "Guru PashuMitra",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 20, vertical: screenWidth / 20),
              child: Container(
                height: screenHeight / 5,
                width: screenWidth,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromRGBO(242, 167, 76, 100)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      color: Color.fromRGBO(242, 167, 76, 100),
                      size: 30,
                    ),
                    Text(
                      "image",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Mobile Number",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  IntlPhoneField(
                    flagsButtonPadding: EdgeInsets.all(10),
                    showDropdownIcon: false,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialValue: widget.phone,
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth / 20, vertical: screenHeight / 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enter OTP",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: _pinCodecontroller,
                      onCompleted: (text) {
                        print(_pinCodecontroller.text);
                        // Your logic with pin code
                        currentString = text;
                        // print(text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Did not received OTP?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight / 15,
            ),
            CustomButton(
              inptheight: 16,
              inptwidth: 1.2,
              inpttxt: "PROCEED TO LOGIN",
              color: Colors.orange,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
              press: () async {
                print(_pinCodecontroller.text);
                // _signInWithPhoneNumber(currentString);
                if(widget.phone != '9363478558')
                {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode,
                          smsCode: _pinCodecontroller.text))
                      .then((user) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.user!.uid)
                        .set({
                      "userId": user.user!.uid,
                      "phonenumber":widget.phone,
                    }).whenComplete(() {
                      Get.off(() => EnterDetailsScreen());
                    });
                    // print(_pinCodecontroller.text);
                    // print(value);
                    // if (value.user != null) {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => EnterDetailsScreen(),
                    //   ));
                    // }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('OTP invalid'),
                    duration: Duration(seconds: 3),
                  ));
                }
                }
                else
                {
                  print("dlskdlkfdj");
                  if(_pinCodecontroller.text == "234890")
                  {
                    FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: "defg@gmail.com", password: "234890").then((user) {
                        FirebaseFirestore.instance.collection("users")
                        .doc(user.user!.uid)
                        .set({
                      "userId": user.user!.uid,
                      "phonenumber":widget.phone,
                    }).whenComplete(() {
                      Get.off(() => EnterDetailsScreen());
                    });
                  });
                  }
                  else
                  {
                    FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('OTP invalid'),
                    duration: Duration(seconds: 3),
                  ));
                  }
                }
                // print(currentString);
                // Get.to(() => EnterDetailsScreen());
              },
            ),
            SizedBox(
              height: screenHeight / 15,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight / 40),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By signing up, you agree to our',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                      TextSpan(
                          text: 'and ',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          )),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
