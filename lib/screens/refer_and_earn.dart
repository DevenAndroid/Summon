import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fresh2_arrive/controller/refer_and_controller.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);
  static var referAndEarnScreen = "/referAndEarnScreen";

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  final key = GlobalKey<ScaffoldState>();
  final controller = Get.put(ReferAndEarnController());
  final String _copy = "YAF5KJHGCX45YTUY";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: backAppBar(title: "Refer & Earn", context: context),
      body: Obx(() {
        return controller.isLoadingData.value?SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * .01),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * .04,
                    ),
                    Image(
                      height: height * .25,
                      width: width,
                      image: const AssetImage(AppAssets.referAndEarn),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    Text(
                      "Earn Free ₹${controller.referAndEarnModel.value.data!.referAmount.toString()}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5!
                          .copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: AppTheme.primaryColor),
                    ),
                    SizedBox(
                      height: height * .005,
                    ),
                    Text(
                      "For every new user your refer",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5!
                          .copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppTheme.blackcolor),
                    ),
                    SizedBox(
                      height: height * .005,
                    ),
                    Text(
                      "Share you referral link and\nearn ₹100",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5!
                          .copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: AppTheme.subText),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.backgroundcolor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                // offset: Offset(2, 2),
                                blurRadius: 15)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04, vertical: height * .02),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                GestureDetector(
                                  child: Image(
                                      height: height * .03,
                                      width: width * .05,
                                      fit: BoxFit.cover,
                                      image: const AssetImage(
                                          AppAssets.shareIcon1)),
                                  onTap: () {
                                    Clipboard.setData(
                                        ClipboardData(text: _copy))
                                        .then((value) =>
                                        Fluttertoast.showToast(
                                            msg: "Copied",
                                            gravity: ToastGravity.CENTER));
                                  },
                                ),
                                SizedBox(
                                  width: width * .04,
                                ),
                                Text(controller.referAndEarnModel.value.data!.referCode.toString(),
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ]),
                              GestureDetector(
                                onTap: () {

                                },
                                child: const Icon(
                                  Icons.share_outlined,
                                  color: AppTheme.primaryColor,
                                  size: 25,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      "Earn Free ₹${controller.referAndEarnModel.value.data!.referAmount.toString()}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5!
                          .copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: AppTheme.blackcolor),
                    ),
                    SizedBox(
                      height: height * .005,
                    ),
                    Text(
                      "For any account you connect",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5!
                          .copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppTheme.blackcolor),
                    ),
                    SizedBox(
                      height: height * .06,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // Get.toNamed(MyRouter.editProfileScreen);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            minimumSize: const Size(double.maxFinite, 55),
                            primary: AppTheme.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        child: Text(
                          "SHARE",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                              color: AppTheme.backgroundcolor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        )),
                  ],
                ),
              ),
            )):Center(child: CircularProgressIndicator());
      }),
    );
  }
}
