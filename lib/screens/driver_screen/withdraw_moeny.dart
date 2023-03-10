import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_banking_details.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../../controller/main_home_controller.dart';
import '../../controller/withdrawalList_Controller.dart';
import '../../repositories/Withdrawal_Request_Repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';
import '../vendor_screen/bank_details.dart';

class DriverWithdrawMoney extends StatefulWidget {
  const DriverWithdrawMoney({Key? key}) : super(key: key);
  static var driverWithdrawMoney = "/driverWithdrawMoney";
  @override
  State<DriverWithdrawMoney> createState() => _DriverWithdrawMoneyState();
}

class _DriverWithdrawMoneyState extends State<DriverWithdrawMoney> {
  final controller = Get.put(MainHomeController());
  final withdrawalListController = Get.put(WithdrawalListController());

  final TextEditingController addMoneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> moneyList = ["+₹500", "+₹800", "+₹1000", "+₹1200"];

  final walletStatus = "";

  @override
  void initState() {
    super.initState();
    withdrawalListController.getWithdrawalList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: "Withdrawal money", context: context),
        body: withdrawalListController.isDataLoading.value
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                                        "My Balance",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: AddSize.font14,
                                                color: AppTheme.blackcolor),
                                      ),
                                      Text(
                                        "₹ ${withdrawalListController.model.value.data!.earnedBalance.toString()}",
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
                                  Image(
                                    image: AssetImage(AppAssets.walletIcon),
                                    height: AddSize.size30,
                                    width: AddSize.size50,
                                  ),
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
                                        decoration: InputDecoration()),
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
                                            print(addMoneyController.text);
                                            withdrawalRequestRepo(
                                                    addMoneyController.text,
                                                    context)
                                                .then((value) {
                                              showToast(value.message);
                                              if(value.status == true){
                                                withdrawalListController.getWithdrawalList();
                                                addMoneyController.clear();
                                                FocusManager.instance.primaryFocus!.unfocus();
                                              }
                                            });
                                            // Get.toNamed(BankDetailsScreen
                                            //     .bankDetailsScreen);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(double.maxFinite,
                                                AddSize.size45),
                                            primary: AppTheme.primaryColor,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            textStyle: TextStyle(
                                                fontSize: AddSize.font20,
                                                fontWeight: FontWeight.w500)),
                                        child: Text(
                                          "Withdrawal".toUpperCase(),
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
                                      "Amount",
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
                                      "Date",
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
                                      "Status",
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
                                Divider(),
                                ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: withdrawalListController
                                      .model.value.data!.withdrawalList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: AddSize.size5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "₹ ${withdrawalListController.model.value.data!.withdrawalList![index].amount.toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      height: 1.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: AddSize.font14),
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
                                                      fontSize: AddSize.font12,
                                                      color:
                                                          Colors.grey.shade500),
                                            ),
                                            withdrawalListController
                                                        .model
                                                        .value
                                                        .data!
                                                        .withdrawalList![index]
                                                        .status ==
                                                    "P"
                                                ? Text(
                                                    withdrawalListController
                                                        .model
                                                        .value
                                                        .data!
                                                        .withdrawalList![index]
                                                        .status!
                                                        .replaceAll(
                                                            "P", "Pending")
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            height: 1.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                AddSize.font14,
                                                            color:
                                                                Colors.green),
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
                                                                "A", "Approve")
                                                            .toString(),
                                                        style: Theme.of(context)
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
                                                                "R", "Reject")
                                                            .toString(),
                                                        style: Theme.of(context)
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
                                                                color: Colors
                                                                    .green),
                                                      ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AddSize.size5,
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            : const Center(child: CircularProgressIndicator()),
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
      label: Text("${title}",
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
