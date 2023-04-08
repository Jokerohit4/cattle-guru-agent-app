import 'package:cattle_guru_agent_app/controllers/phone_number/auth_controller.dart';
import 'package:cattle_guru_agent_app/screens/Auth/OTP_screen.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:cattle_guru_agent_app/widgets/Custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  final _phone = TextEditingController();
  final _countryCode = "IN";
  final _countryPhoneCode = "+91";
  final validatorNumber =
      ValidationBuilder(requiredMessage: "Please enter your phone number.")
          .phone()
          .build();
  String pin = "";

  void fn(String pin) {
    pin = this.pin;
    print(pin);
  }

  Future<bool?> _validate() async {
    return _loginForm.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    String currentString = "";
    return Scaffold(
      body: GetBuilder(
          init: authController,
          builder: (_) {
            return Form(
              key: _loginForm,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth / 5),
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
                          horizontal: screenWidth / 20,
                          vertical: screenWidth / 20),
                      child: Container(
                        height: screenHeight / 5,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(242, 167, 76, 100)),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth / 15),
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
                            keyboardType: TextInputType.phone,
                            validator: (p0) {
                              if (p0 == null) {
                                return "Enter valid mobile number";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            initialCountryCode: 'IN',
                            controller: _phone,
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 20,
                          vertical: screenHeight / 40),
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
                              onChanged: (String pin) {
                                currentString = pin;
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
                                          decoration:
                                              TextDecoration.underline)),
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
                        inpttxt: "Send OTP",
                        color: Colors.orange,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        press: () async {
                          await _validate().then((value) {
                            if (value == true) {
                              String number =
                                  "$_countryPhoneCode ${_phone.text}";
                              print(number);
                            }
                          });
                          Get.to(() => OTPScreen(
                                codeDigit: "+91",
                                phone: _phone.text,
                              ));
                        }),
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
                            children: <TextSpan>[
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
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(
                                          "https://www.cattleguru.in/privacy-policy")) {
                                        launch(
                                            "https://www.cattleguru.in/privacy-policy");
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: new Text(
                                                    "Couldnt launch url")));
                                      }
                                    },
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
          }),
    );
  }
}
