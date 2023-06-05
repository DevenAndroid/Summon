import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/MyOrder_Details_Controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import 'Language_Change_Screen.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);
  static var thankYouScreen = "/thankYouScreen";
  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  final myOrderDetailsController = Get.put(MyOrderDetailsController());

  @override
  void initState() {
    super.initState();
    // myOrderDetailsController.getMyOrderDetails();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
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
                    image: const AssetImage(AppAssets.thankYOU),
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                  Text(
                    "Thank You!".tr,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AddSize.font24,
                        color: AppTheme.blackcolor),
                  ),
                  SizedBox(
                    height: height * .005,
                  ),
                  Text(
                    "your order has been successful".tr,
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
                                      backgroundColor: AppTheme.primaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6)),
                                    ),
                                    child: Text(
                                      Get.arguments[0].toString(),
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
                                  Text("Order ID:".tr,
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                    "#${Get.arguments[1].toString()}",
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
                                  Text("Date:".tr,
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w500)),
                                  Text(Get.arguments[2].toString(),
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
                                  Text("Payment Type:".tr,
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w500)),
                                  Text("${Get.arguments[3].toString()}",
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
                                  Expanded(
                                    child: Text("Subtotal:".tr,
                                        style: TextStyle(
                                            color: AppTheme.blackcolor,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Text("${Get.arguments[4].toString()}",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(width: 5,),
                                  Text("SR",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w500)),

                                ]),
                            SizedBox(
                              height: height * .01,
                            ),

                            Get.arguments[5].toString() != "" &&
                                Get.arguments[5].toString() != "null"
                        ?
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text("Coupon Discount:".tr,
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w500)),
                                  Text("${Get.arguments[5].toString()}",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w500)),
                                ]):SizedBox(),
                            SizedBox(
                              height: height * .01,
                            ),
                            Get.arguments[6].toString() != "0" ?
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Wallet Savings:".tr,
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w500)),
                                  Text("₹${Get.arguments[6].toString()}",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w500)),
                                ]):SizedBox(),
                            SizedBox(
                              height: height * .01,
                            ),
                                  Get.arguments[7].toString() != "0" &&
                                      Get.arguments[7].toString() !="" ?
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery charges:".tr,
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: AddSize.font16,
                                          fontWeight: FontWeight.w500)),
                                  Text("₹${Get.arguments[7].toString()}",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w500)),
                                ]):SizedBox(),
                            SizedBox(
                              height: height * .01,
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text("Total:".tr,
                                        style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: AddSize.font16,
                                            fontWeight: FontWeight.w500)),
                                  ),

                                  Text("${Get.arguments[8].toString()}",
                                      style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(width: 5,),
                                  Text("SR",
                                      style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontSize: AddSize.font16,
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
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  minimumSize: const Size(double.maxFinite, 60),
                  side: const BorderSide(color: AppTheme.primaryColor, width: 2),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {
                   myOrderDetailsController.id.value = Get.arguments[1].toString();
                   // print("Order id is...${myOrderDetailsController.id.value}");
                   Get.back();
                  Get.toNamed(OrderDetails.orderDetailsScreen);
                },
                child: Text(
                  'ORDER DETAILS'.tr,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font16),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(CustomNavigationBar.customNavigationBar);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 60),
                      backgroundColor: AppTheme.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AddSize.size10)),
                      textStyle: TextStyle(
                          fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "BACK TO HOME".tr,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AppTheme.backgroundcolor,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font16),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
