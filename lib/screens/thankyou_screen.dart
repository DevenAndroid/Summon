import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';

import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../routers/my_router.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);
  static var thankYouScreen = "/thankYouScreen";
  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AddSize.padding16, vertical: AddSize.padding16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * .08,
            ),
            Image(
              height: height * .25,
              width: width,
              image: AssetImage(AppAssets.thankYou),
            ),
            SizedBox(
              height: height * .04,
            ),
            Text(
              "Thank You!",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AddSize.font24,
                  color: AppTheme.blackcolor),
            ),
            SizedBox(
              height: height * .005,
            ),
            Text(
              "your order has been successful",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: AddSize.font16,
                  color: AppTheme.blackcolor),
            ),
            SizedBox(
              height: height * .04,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 0,
              color: Colors.grey.shade100,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding20,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // Get.toNamed(MyRouter.editProfileScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                    Size(AddSize.size50, AddSize.size25),
                                primary: AppTheme.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Text(
                                "COD",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: AppTheme.backgroundcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font12),
                              )),
                          SizedBox(
                            width: AddSize.size10,
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order ID:",
                                style: TextStyle(
                                    color: AppTheme.blackcolor,
                                    fontSize: AddSize.font16,
                                    fontWeight: FontWeight.w500)),
                            Text(
                              "#254600",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date:",
                                style: TextStyle(
                                    color: AppTheme.blackcolor,
                                    fontSize: AddSize.font16,
                                    fontWeight: FontWeight.w500)),
                            Text("24-11-2022",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: AddSize.font14,
                                    fontWeight: FontWeight.w500)),
                          ]),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal:",
                                style: TextStyle(
                                    color: AppTheme.blackcolor,
                                    fontSize: AddSize.font16,
                                    fontWeight: FontWeight.w500)),
                            Text("₹35.00",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: AddSize.font14,
                                    fontWeight: FontWeight.w500)),
                          ]),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tax and fee:",
                                style: TextStyle(
                                    color: AppTheme.blackcolor,
                                    fontSize: AddSize.font16,
                                    fontWeight: FontWeight.w500)),
                            Text("₹5.00",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: AddSize.font14,
                                    fontWeight: FontWeight.w500)),
                          ]),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery:",
                                style: TextStyle(
                                    color: AppTheme.blackcolor,
                                    fontSize: AddSize.font16,
                                    fontWeight: FontWeight.w500)),
                            Text("Free",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: AddSize.font14,
                                    fontWeight: FontWeight.w500)),
                          ]),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Packing fee:",
                                style: TextStyle(
                                    color: AppTheme.blackcolor,
                                    fontSize: AddSize.font16,
                                    fontWeight: FontWeight.w500)),
                            Text("Free",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: AddSize.font14,
                                    fontWeight: FontWeight.w500)),
                          ]),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total:",
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: AddSize.font16,
                                    fontWeight: FontWeight.w500)),
                            Text("₹40.00",
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: AddSize.font14,
                                    fontWeight: FontWeight.w500)),
                          ]),
                    ]),
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              child: Text(
                'ORDER DETAILS',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font16),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.maxFinite, 60),
                primary: AppTheme.primaryColor,
                side: BorderSide(color: AppTheme.primaryColor, width: 2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {
                Get.toNamed(OrderDetails.orderDetailsScreen);
              },
            ),
            SizedBox(
              height: height * .01,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(CustomNavigationBar.customNavigationBar);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.maxFinite, 60),
                    primary: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AddSize.size10)),
                    textStyle: TextStyle(
                        fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                child: Text(
                  "BACK TO HOME",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font16),
                )),
          ],
        ),
      ),
    );
  }
}
