import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';

import '../widgets/dimensions.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);
  static var privacyPolicyScreen = "/privacyPolicyScreen";
  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Privacy Policy", context: context),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16,
                vertical: AddSize.padding10,
              ),
              child: Container(
                  decoration: BoxDecoration(color: AppTheme.backgroundcolor),
                  child: Column(
                      children: List.generate(
                          4,
                          (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Lorem Ipsum is simply dummytext of the printing",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font16),
                                    ),
                                    Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              fontWeight: FontWeight.w300,
                                              fontSize: AddSize.font12),
                                    ),
                                  ],
                                ),
                              ))))),
        ));
  }
}
