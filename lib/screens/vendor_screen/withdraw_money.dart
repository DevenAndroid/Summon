import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../../controller/main_home_controller.dart';
import '../../controller/withdrawalList_Controller.dart';
import '../../repositories/Withdrawal_Request_Repo.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';
import '../Language_Change_Screen.dart';

class WithDrawMoney extends StatefulWidget {
  const WithDrawMoney({Key? key}) : super(key: key);
  static var withDrawMoney = "/withDrawMoney";

  @override
  State<WithDrawMoney> createState() => _WithDrawMoneyState();
}

class _WithDrawMoneyState extends State<WithDrawMoney> {
  final controller = Get.put(MainHomeController());
  final withdrawalListController = Get.put(WithdrawalListController());

  final TextEditingController addMoneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> moneyList = ["500", "800", "1000", "1200"];

  final walletStatus = "";

  @override
  void initState() {
    super.initState();
    withdrawalListController.getWithdrawalList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      return Directionality(
        textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "Withdrawal money".tr, context: context),
          body: withdrawalListController.isDataLoading.value
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: AppTheme.backgroundcolor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "My Balance".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AddSize.font14,
                                                  color: AppTheme.blackcolor),
                                        ),
                                        Text(
                                          "SR ${withdrawalListController.model.value.data!.earnedBalance.toString()}.00",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: AddSize.font24,
                                                  color: AppTheme.blackcolor),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(Icons.account_balance_wallet_sharp,color: Colors.white,),
                                    )
                                    // Image(image:const AssetImage(AppAssets.walletIcon),
                                    //   height: AddSize.size30,
                                    //   width: AddSize.size50,
                                    // ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: AppTheme.backgroundcolor,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: AppTheme.blackcolor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: AddSize.font24),
                                          controller: addMoneyController,
                                          cursorColor: AppTheme.primaryColor,
                                          validator: validateMoney,
                                          decoration: const InputDecoration()),
                                      SizedBox(
                                        height: AddSize.size15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          moneyList.length,
                                          (index) => chipList(moneyList[index]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: AddSize.size25,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              log(addMoneyController.text);
                                              withdrawalRequestRepo(
                                                      addMoneyController.text,
                                                      context)
                                                  .then((value) {
                                                showToast(value.message);
                                                if (value.status == true) {
                                                  withdrawalListController
                                                      .getWithdrawalList();
                                                  addMoneyController.clear();
                                                  FocusManager
                                                      .instance.primaryFocus!
                                                      .unfocus();
                                                } else if (value.status ==
                                                    false) {
                                                  showToast(value.message);
                                                }
                                              });
                                              // Get.toNamed(BankDetailsScreen
                                              //     .bankDetailsScreen);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(double.maxFinite,
                                                  AddSize.size45),
                                              backgroundColor:
                                                  AppTheme.primaryColor,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              textStyle: TextStyle(
                                                  fontSize: AddSize.font20,
                                                  fontWeight: FontWeight.w500)),
                                          child: Text(
                                            "Withdrawal".tr.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    color:
                                                        AppTheme.backgroundcolor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font16),
                                          )),
                                    ],
                                  ))),
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                // color: AppTheme.backgroundcolor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Amount".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font14,
                                                color: AppTheme.primaryColor),
                                      ),
                                      Text(
                                        "Date".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font14,
                                                color: AppTheme.primaryColor),
                                      ),
                                      Text(
                                        "Status".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font14,
                                                color: AppTheme.primaryColor),
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  withdrawalListController.model.value.data!
                                          .withdrawalList!.isNotEmpty
                                      ? ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: withdrawalListController
                                              .model
                                              .value
                                              .data!
                                              .withdrawalList!
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: AddSize.size5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "₹ ${withdrawalListController.model.value.data!.withdrawalList![index].amount.toString()}.00",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              height: 1.5,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              fontSize:
                                                                  AddSize.font14),
                                                    ),
                                                    Text(
                                                      withdrawalListController
                                                          .model
                                                          .value
                                                          .data!
                                                          .withdrawalList![index]
                                                          .date
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              height: 1.5,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              fontSize:
                                                                  AddSize.font12,
                                                              color: Colors
                                                                  .grey.shade500),
                                                    ),
                                                    withdrawalListController
                                                                .model
                                                                .value
                                                                .data!
                                                                .withdrawalList![
                                                                    index]
                                                                .status ==
                                                            "P"
                                                        ? Text(
                                                            withdrawalListController
                                                                .model
                                                                .value
                                                                .data!
                                                                .withdrawalList![
                                                                    index]
                                                                .status!
                                                                .replaceAll("P",
                                                                    "Pending")
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5!
                                                                .copyWith(
                                                                    height: 1.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        AddSize
                                                                            .font14,
                                                                    color: const Color(
                                                                        0xffFFB26B)),
                                                          )
                                                        : withdrawalListController
                                                                    .model
                                                                    .value
                                                                    .data!
                                                                    .withdrawalList![
                                                                        index]
                                                                    .status ==
                                                                "A"
                                                            ? Text(
                                                                withdrawalListController
                                                                    .model
                                                                    .value
                                                                    .data!
                                                                    .withdrawalList![
                                                                        index]
                                                                    .status!
                                                                    .replaceAll(
                                                                        "A",
                                                                        "Approve")
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline5!
                                                                    .copyWith(
                                                                        height:
                                                                            1.5,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            AddSize
                                                                                .font14,
                                                                        color: Colors
                                                                            .green),
                                                              )
                                                            : Text(
                                                                withdrawalListController
                                                                    .model
                                                                    .value
                                                                    .data!
                                                                    .withdrawalList![
                                                                        index]
                                                                    .status!
                                                                    .replaceAll(
                                                                        "R",
                                                                        "Reject")
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline5!
                                                                    .copyWith(
                                                                        height:
                                                                            1.5,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            AddSize
                                                                                .font14,
                                                                        color: const Color(
                                                                            0xffFF557E)),
                                                              ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: AddSize.size5,
                                                ),
                                                const Divider(),
                                              ],
                                            );
                                          },
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding20 * 3,
                                              vertical: AddSize.padding20),
                                          child: Text("Request not Available".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      height: 1.5,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: AddSize.font14,
                                                      color:
                                                          AppTheme.blackcolor)),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              : const Center(child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
          )),
        ),
      );
    });
  }

  chipList(title) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChoiceChip(
      padding: EdgeInsets.symmetric(
          horizontal: width * .005, vertical: height * .005),
      backgroundColor: AppTheme.backgroundcolor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.grey.shade300)),
      label: Text("+${title}",
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      selected: false,
      onSelected: (value) {
        setState(() {
          addMoneyController.text = title;
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
    );
  }
}
