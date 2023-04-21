import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/registration_form_textField.dart';
import 'Otp_Screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static var setPasswordScreen = "/setPasswordScreen";
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
                top: -40,
                left: 0,
                right: -320,
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(AppAssets.BG1),
                )),
            Positioned(
                top: 20,
                left: -350,
                right: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(AppAssets.BG3),
                )),
            Positioned(
                top: -30,
                left: -180,
                right: 0,
                child: Container(
                  height: 130,
                  width: 130,
                  child: Image.asset(AppAssets.BG2),
                )),
            Positioned(
                top: 70,
                left: -300,
                right: 0,
                child: Container(
                  height: 45,
                  width: 45,
                  child: Image.asset(AppAssets.BACKICON),
                )),
            Positioned.fill(child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 35,right: 25,top: 40),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 90,),
                      Text("Forget Password", style: TextStyle(fontSize: 33, color:Color(0xff000000), fontWeight:FontWeight.w500 ),),
                      SizedBox(height: 7,),
                      Text("Please enter your email address to request\na Forget Password",
                        style: TextStyle(fontSize: 14, color:Color(0xff000000), fontWeight:FontWeight.w300 ),),
                      SizedBox(height: 26,),
                      RegistrationTextField1(
                        hint: "Enter your Email id",
                        controller: emailController,
                        validator: MultiValidator([
                          EmailValidator(
                              errorText:
                              'enter a valid email address'),
                          RequiredValidator(
                              errorText: 'email is required')
                        ]),
                      ),
                      SizedBox(height: 45,),
                      ElevatedButton(
                          onPressed: () async {
                            Get.to(OtpScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppTheme.primaryColor,
                              minimumSize: const Size(double.maxFinite, 60),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          child: const Text(
                            "Send",
                          )),

                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
