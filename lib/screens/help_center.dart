import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../controller/HelpCenter_Controller.dart';
import '../widgets/dimensions.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);
  static var helpCenterScreen = "/helpCenterScreen";

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final helpCenterController = Get.put(HelpCenterController());
  final RxList<bool> _value = [true, false, false, false, false, false].obs;

  @override
  void initState() {
    super.initState();
    helpCenterController.getHelpCenterData().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: backAppBar(title: "Help Center", context: context),
          body: helpCenterController.isDataLoading.value
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10,
                      ),
                      child: Obx(() {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.backgroundcolor,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        // offset: Offset(2, 2),
                                        blurRadius: 15)
                                  ]),
                              child: TextField(
                                maxLines: 1,
                                controller:
                                    helpCenterController.searchController,
                                style: const TextStyle(fontSize: 17),
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.search,
                                onChanged: (value) =>
                                    {helpCenterController.searchController},
                                decoration: InputDecoration(
                                    filled: true,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        helpCenterController
                                            .getHelpCenterData();
                                      },
                                      icon: const Icon(
                                        Icons.search,
                                        color: AppTheme.blackcolor,
                                        size: 25,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding20,
                                        vertical: AddSize.padding10),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        fontSize: AddSize.font14,
                                        color: AppTheme.blackcolor,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            Column(
                                children: List.generate(
                                    helpCenterController
                                        .model.value.data!.length,
                                    (index) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: AddSize.size5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme.backgroundcolor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade300,
                                                      // offset: Offset(2, 2),
                                                      blurRadius: 15)
                                                ]),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: AddSize.padding20,
                                                  vertical: AddSize.padding10),
                                              child: Obx(() {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _value[index] =
                                                            !_value[index];
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            helpCenterController
                                                                .model
                                                                .value
                                                                .data![index]
                                                                .question
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        AddSize
                                                                            .font16),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              _value[index] =
                                                                  !_value[
                                                                      index];
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_outlined,
                                                              size: AddSize
                                                                  .size20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    _value[index] == true
                                                        ? Text(
                                                            helpCenterController
                                                                .model
                                                                .value
                                                                .data![index]
                                                                .answer
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        AddSize
                                                                            .font12),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                        ))),
                          ],
                        );
                      })),
                )
              : const Center(child: CircularProgressIndicator()));
    });
  }
}
