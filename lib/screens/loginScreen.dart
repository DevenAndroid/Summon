import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/otpscreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/login_repository.dart';
import '../routers/my_router.dart';
import '../widgets/add_text.dart';
import '../widgets/commonTextField.dart';
import '../widgets/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static var loginScreen = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  bool? _isValue = false;
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: [
      Form(
          key: _formKey,
          child: ListView(
            children: [
              const Image(image: AssetImage(AppAssets.login)),
              Container(
                decoration: const BoxDecoration(
                    color: AppTheme.otpcolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * .02,
                        ),
                        Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        // CommonTextFieldWidget(
                        //     controller: phoneNumberController,
                        //     hint: "Mobile Number",
                        //     keyboardType: TextInputType.number,
                        //     validator: validateMobile,
                        //     length: 10,
                        //     prefix: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         SizedBox(
                        //           width: width * .02,
                        //         ),
                        //         Text(
                        //           "+91",
                        //           style: TextStyle(
                        //               color: AppTheme.userText,
                        //               fontSize: AddSize.font14),
                        //         ),
                        //         SizedBox(
                        //           width: width * .02,
                        //         ),
                        //         Container(
                        //           height: height * .03,
                        //           width: width * .003,
                        //           color: AppTheme.greycolor,
                        //         ),
                        //       ],
                        //     )),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 10,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              hintText: "Mobile Number",
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: width * .02,
                                  ),
                                  Text(
                                    "+91",
                                    style: TextStyle(
                                        color: AppTheme.userText,
                                        fontSize: AddSize.font14),
                                  ),
                                  SizedBox(
                                    width: width * .02,
                                  ),
                                  Container(
                                    height: height * .03,
                                    width: width * .003,
                                    color: AppTheme.greycolor,
                                  ),
                                ],
                              )),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return 'Please enter 10 digit number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        CommonTextFieldWidget(
                          controller: referralCodeController,
                          hint: "Referral Code(Optional)",
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                side: BorderSide(
                                    color: showValidation == false
                                        ? AppTheme.primaryColor
                                        : Colors.red,
                                    width: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                value: _isValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isValue = value;
                                  });
                                }),
                            Expanded(
                                child: Text(
                              "By continuing, you agree to our Terms of service & Privacy policy",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _isValue == true) {
                                createLogin(phoneNumberController.text,
                                        referralCodeController.text, context)
                                    .then((value) async {
                                  if (value.status == true) {
                                    showToast(
                                        "This is your login OTP ${value.data.toString()}");
                                    Get.toNamed(OtpScreen.otpScreen,
                                        arguments: [
                                          phoneNumberController.text,
                                          value.data.toString()
                                        ]);
                                  } else {
                                    Get.defaultDialog(
                                        title: 'Log In',
                                        titleStyle: const TextStyle(
                                            color: AppTheme.primaryColor),
                                        middleTextStyle: const TextStyle(
                                            color: Colors.white),
                                        textConfirm: "Okay",
                                        onConfirm: () {
                                          Get.back();
                                        },
                                        confirmTextColor: Colors.white,
                                        buttonColor: AppTheme.primaryColor,
                                        radius: 10,
                                        content: Text(value.message!));
                                    // showToast(value.message);
                                  }
                                  return;
                                });
                              } else {
                                showValidation = true;
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: AppTheme.primaryColor,
                                minimumSize: const Size(double.maxFinite, 60),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            child: const Text(
                              "LOGIN",
                            )),
                      ]),
                ),
              )
            ],
          ))
    ]));
  }
}
