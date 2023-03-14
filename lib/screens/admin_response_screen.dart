import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/main_home_controller.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_dashboard.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';

class AdminResponseScreen extends StatefulWidget {
  const AdminResponseScreen({Key? key}) : super(key: key);
  static var adminResponseScreen = "/adminResponseScreen";

  @override
  State<AdminResponseScreen> createState() => _AdminResponseScreenState();
}

class _AdminResponseScreenState extends State<AdminResponseScreen> {

  final controller = Get.put(MainHomeController());
  final profileController = Get.put(ProfileController());
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
                  "Wait For Admin Response Your Account Under Review",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font24,
                      color: AppTheme.blackcolor),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
              ],
            ),
          )),
    );
  }
}
