import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_dashboard.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';

class ThankYouVendorScreen extends StatefulWidget {
  const ThankYouVendorScreen({Key? key}) : super(key: key);
  static var thankYouVendorScreen = "/thankYouVendorScreen";
  @override
  State<ThankYouVendorScreen> createState() => _ThankYouVendorScreenState();
}

class _ThankYouVendorScreenState extends State<ThankYouVendorScreen> {
  @override
  Widget build(BuildContext context) {
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
              height: AddSize.size45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image(
                height: AddSize.size300,
                width: double.maxFinite,
                image: const AssetImage(AppAssets.thankYou),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: AddSize.size30,
            ),
            Text(
              "Your Account Has Been\nSuccessfully Created",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: AddSize.font24,
                  color: AppTheme.blackcolor),
            ),
            SizedBox(
              height: AddSize.size15,
            ),
            Text(
              "Admin will verify and update you by\ncall or email",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: AddSize.font14,
                  color: AppTheme.lightblack),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AddSize.padding16, vertical: AddSize.size40),
        child: ElevatedButton(
            onPressed: () {
              Get.offAndToNamed(VenderDashboard.vendorDashboard);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 60),
                primary: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AddSize.size10)),
                textStyle: TextStyle(
                    fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
            child: Text(
              "CONTINUE",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppTheme.backgroundcolor,
                  fontWeight: FontWeight.w500,
                  fontSize: AddSize.font18),
            )),
      ),
    );
  }
}
