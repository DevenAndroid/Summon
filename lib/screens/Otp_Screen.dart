import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';
import '../widgets/registration_form_textField.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);
  static var setPasswordScreen = "/setPasswordScreen";
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController=TextEditingController();
  RxBool hasError1 = false.obs;

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
                padding: const EdgeInsets.only(left: 30,right: 25,top: 40),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 90,),
                      Text("Verification Code", style: TextStyle(fontSize: 33, color:Color(0xff000000), fontWeight:FontWeight.w500, ),),
                      SizedBox(height: 7,),
                      Text("Please type the verification code sent to\nmosharrafmamun210@gmail.com",
                        style: TextStyle(fontSize: 16, color:Color(0xffA5A5AD), fontWeight:FontWeight.w300 ),),
                      SizedBox(height: 36,),
                  PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    cursorColor: AppTheme.primaryColor,
                    appContext: context,
                    textStyle: const TextStyle(
                      color: AppTheme.blackcolor,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: otpController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "";
                      } else if (v.length != 4) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    length: 4,
                    pinTheme: PinTheme(
                      inactiveFillColor: AppTheme.primaryColor,
                      selectedColor: AppTheme.primaryColor,
                      disabledColor: AppTheme.primaryColor,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldWidth: AddSize.size30 * 1.6,
                      fieldHeight: AddSize.size30 * 1.6,
                      borderWidth: 1,
                      activeColor: AppTheme.primaryColor,
                      inactiveColor: !hasError1.value
                          ? AppTheme.primaryColor
                          : Colors.red.withOpacity(.8),
                      errorBorderColor: Colors.red,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      if (v.length == 4) {
                        hasError1.value = false;
                      }
                    },
                  ),
                      SizedBox(height: 36,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("I don’t recevie a code! ",
                            style: TextStyle(fontSize: 16, color:Color(0xff999999), fontWeight:FontWeight.w400 ),),
                          Text("Please resend",
                            style: TextStyle(fontSize: 16, color:Color(0xffFE724C), fontWeight:FontWeight.w400 ),),
                        ],
                      ),
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
