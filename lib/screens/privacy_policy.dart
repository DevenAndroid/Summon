import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/HelpCenter_Controller.dart';
import '../widgets/dimensions.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);
  static var privacyPolicyScreen = "/privacyPolicyScreen";
  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final privacyController=Get.put(HelpCenterController());

  @override
  void initState() {
    super.initState();
    privacyController.getPrivacyPolicyData();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
      Scaffold(
          appBar: backAppBar(title: "Privacy Policy", context: context),
          body:
          Obx((){
            return privacyController.isGettingData.value ?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16,
                    vertical: AddSize.padding10,
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.backgroundcolor),
                      child: Column(
                          children: List.generate(
                              1,
                                  (index) =>
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding10),
                                    child: Column(
                                      children: [
                                        Text(
                                          privacyController.privacyModel.value
                                              .data!.title.toString(),
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font16),
                                        ),
                                        Html(
                                            data: privacyController.privacyModel
                                                .value.data!.content.toString())
                                      ],
                                    ),
                                  ))))),
            ):Center(child: CircularProgressIndicator());

          } )),
    );
  }
}
