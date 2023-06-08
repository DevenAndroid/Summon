import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivery_dashboard.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';

class OrderDeclineScreen extends StatefulWidget {
  const OrderDeclineScreen({Key? key}) : super(key: key);
  static var orderDeclineScreen = "/orderDeclineScreen";
  @override
  State<OrderDeclineScreen> createState() => _OrderDeclineScreenState();
}

class _OrderDeclineScreenState extends State<OrderDeclineScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
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
                height: AddSize.size30 * 2.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Image(
                  height: AddSize.size300,
                  width: double.maxFinite,
                  image: const AssetImage(AppAssets.orderDecline),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: AddSize.size50,
              ),
              Text(
                "Your Order is Decline",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: const Color(0xffF94D4D)),
              ),
              // Text(
              //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.headline5!.copyWith(
              //       fontWeight: FontWeight.w500,
              //       fontSize: AddSize.font14,
              //       color: const Color(0xff596774)),
              // ),
            ],
          ),
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.offAndToNamed(DeliveryDashboard.deliveryDashboard);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 60),
                      primary: const Color(0xffF94D4D),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AddSize.size10)),
                      textStyle: TextStyle(
                          fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Continue".toUpperCase(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AppTheme.backgroundcolor,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font16),
                  )),
              SizedBox(
                height: AddSize.size20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
