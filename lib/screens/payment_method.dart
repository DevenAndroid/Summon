import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/thankyou_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);
  static var paymentScreen = "/paymentScreen";
  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool _isValue = false;
  RxString selectedValue = "cash".obs;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar(title: "Select Payment Method", context: context),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image(
                              image: const AssetImage(AppAssets.paymentIcon1),
                              height: height * .03,
                              width: width * .10,
                            ),
                            SizedBox(
                              width: width * .04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "My Wallet balance",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.blackcolor,
                                          fontSize: 14),
                                ),
                                Text(
                                  "₹2400",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                ),
                              ],
                            ),
                          ]),
                          Checkbox(
                              side: const BorderSide(
                                  color: AppTheme.primaryColor, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                              value: _isValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isValue = value!;
                                });
                              })
                        ],
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    selectedValue.value = "card";
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image(
                                image:
                                    const AssetImage(AppAssets.mastercardIcon),
                                height: height * .04,
                                width: width * .10,
                              ),
                              SizedBox(
                                width: width * .04,
                              ),
                              Text(
                                "Card",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.blackcolor,
                                        fontSize: 16),
                              ),
                            ]),
                            Obx(() {
                              return Radio<String>(
                                value: "card",
                                groupValue: selectedValue.value,
                                onChanged: (value) {
                                  selectedValue.value = value!;
                                },
                              );
                            }),
                          ],
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    selectedValue.value = "cash";
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image(
                                image: const AssetImage(AppAssets.cashIcon),
                                height: height * .03,
                                width: width * .08,
                              ),
                              SizedBox(
                                width: width * .04,
                              ),
                              Text(
                                "Cash on delivery",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.blackcolor,
                                        fontSize: 16),
                              ),
                            ]),
                            Obx(() {
                              return Radio<String>(
                                value: "cash",
                                groupValue: selectedValue.value,
                                onChanged: (value) {
                                  selectedValue.value = value!;
                                },
                              );
                            }),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: ElevatedButton(
            onPressed: () {
              Get.toNamed(ThankYouScreen.thankYouScreen);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 60),
                primary: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            child: Text(
              "PAY NOW",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppTheme.backgroundcolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            )),
      ),
    );
  }
}
