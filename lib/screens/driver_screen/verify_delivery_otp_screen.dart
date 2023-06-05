import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivered_successfully.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../repositories/delivery_verify_otp_repo.dart';
import '../../resources/app_theme.dart';

class VerifyOtpDeliveryScreen extends StatefulWidget {
  const VerifyOtpDeliveryScreen({Key? key}) : super(key: key);
  static var verifyOtpDeliveryScreen = "/verifyOtpDeliveryScreen";
  @override
  State<VerifyOtpDeliveryScreen> createState() =>
      _VerifyOtpDeliveryScreenState();
}

class _VerifyOtpDeliveryScreenState extends State<VerifyOtpDeliveryScreen> {
  TextEditingController otpController = TextEditingController();
  RxBool hasError1 = false.obs;
  late Timer timer;
  RxInt timerSeconds = 30.obs;
  RxBool showTimer = false.obs;
  setTimer() {
    if (showTimer.value == false) {
      showTimer.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (value) {
        if (timerSeconds.value > 1) {
          timerSeconds.value--;
        } else {
          showTimer.value = false;
          timer.cancel();
          timerSeconds.value = 30;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16, vertical: AddSize.padding10),
              child: Column(
                children: [
                  SizedBox(height: AddSize.size30 * 3),
                  Text(
                    "Please ask customer to OTP and verify the delivery",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.blackcolor,
                        fontSize: AddSize.font20),
                  ),
                  SizedBox(height: AddSize.size50),
                  Text(
                    "Enter Your Pin",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.blackcolor,
                        fontSize: AddSize.font14),
                  ),
                  SizedBox(height: AddSize.size40),
                  Obx(() {
                    return PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      cursorColor: AppTheme.primaryColor,
                      appContext: context,
                      textStyle: const TextStyle(color: AppTheme.blackcolor),
                      controller: otpController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
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
                        inactiveFillColor: AppTheme.lightblack,
                        selectedColor: AppTheme.primaryColor,
                        disabledColor: AppTheme.primaryColor,
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(5),
                        fieldWidth: 60,
                        fieldHeight: 50,
                        borderWidth: 3,
                        activeColor: AppTheme.primaryColor,
                        inactiveColor: !hasError1.value
                            ? Colors.black
                            : Colors.red.withOpacity(.8),
                        errorBorderColor: Colors.red,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        if (v.length == 4) {
                          hasError1.value = false;
                        }
                      },
                    );
                  }),
                  SizedBox(height: AddSize.size30),
                  ElevatedButton(
                      onPressed: () {
                        // orderDeliveryRepo(
                        //         orderId: Get.arguments[0],
                        //         status: "delivered",
                        //         context: context)
                        //     .then((value) {
                        //   showToast(value.message.toString());
                        //   if (value.status == true) {
                        //     Get.offAndToNamed(DeliveredSuccessfullyScreen
                        //         .deliveredSuccessfullyScreen);
                        //   }
                        // });
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          minimumSize: const Size(double.maxFinite, 50),
                          primary: AppTheme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      child: Text(
                        "confirm delivery".toUpperCase(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppTheme.backgroundcolor,
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font16),
                      )),
                   TextButton(onPressed: () {
                        if (showTimer.value == false) {
                          resendDeliveryOtpVerify(
                              orderId: Get.arguments[0], context: context).then((value) async {
                            if (value.status == true) {
                              showToast("${value.message}");
                              setTimer();
                            } else {
                              showToast(value.message);
                            }
                            return;
                          });
                        }
                      }, child: Obx(() {
                        return Text(
                          !showTimer.value
                              ? "Resend OTP"
                              : "Resend OTP in 00:${timerSeconds.value > 9 ? timerSeconds.value : "0${timerSeconds.value}"}",
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppTheme.primaryColor),
                        );
                      }))
                ],
              ),
            )),
      ),
    );
  }
}
