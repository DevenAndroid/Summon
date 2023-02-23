import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/add_money.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/myWallet_controller.dart';
import '../model/time_model.dart';
import '../resources/app_assets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);
  static var myWalletScreen = "/myWalletScreen";

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final myWalletController = Get.put(MyWalletController());

  @override
  void initState() {
    super.initState();
    myWalletController.getWalletData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: "My Wallet", context: context),
        body: myWalletController.isDataLoading.value
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding16,
                      vertical: AddSize.padding10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 160,
                                    width: 170,
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: AppTheme.primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image(
                                              image: const AssetImage(
                                                  AppAssets.walletIcon),
                                              height: AddSize.size40,
                                              width: AddSize.size40,
                                            ),
                                            Text(
                                              '₹ ${myWalletController.model.value.data!.totalAmount.toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: AddSize.font24,
                                                      color: AppTheme
                                                          .backgroundcolor),
                                            ),
                                            Text(
                                              "Total Balance",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: AddSize.font14,
                                                      color: AppTheme
                                                          .backgroundcolor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 160,
                                    width: 170,
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: AppTheme.primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image(
                                              image: const AssetImage(
                                                  AppAssets.walletIcon),
                                              height: AddSize.size40,
                                              width: AddSize.size40,
                                            ),
                                            Text(
                                              '₹ ${myWalletController.model.value.data!.withdrawalbleAmount.toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: AddSize.font24,
                                                      color: AppTheme
                                                          .backgroundcolor),
                                            ),
                                            Text(
                                              "Withdrawal balance",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: AddSize.font14,
                                                      color: AppTheme
                                                          .backgroundcolor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      SizedBox(
                        height: AddSize.size125,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                List.generate(walletModel.length, (index) {
                              return GestureDetector(
                                  child: listdata(
                                      walletModel[index].image,
                                      walletModel[index].value.toString(),
                                    walletModel[index].color),
                                  onTap: () {
                                    log("user type${walletModel[index].key}");
                                    myWalletController.userType.value =
                                        walletModel[index].key;
                                    print("user type${walletModel[index].key}");
                                    myWalletController.getWalletData();
                                    setState(() {});
                                  });
                            })

                            // listdata(AppAssets.allIcon, "All",
                            //     AppTheme.appPrimaryPinkColor),
                            // listdata(AppAssets.store, "Vendor",
                            //     AppTheme.appPrimaryGreenColor),
                            // listdata(AppAssets.driverIcon, "Driver",
                            //     AppTheme.appPrimaryYellowColor),
                            // listdata(AppAssets.personIcon, "Customer",
                            //     AppTheme.appPrimaryOrangeColor),
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(2, 2),
                                  blurRadius: 15)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.backgroundcolor),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: myWalletController
                                .model.value.data!.walletTransactions!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Container(
                                            height: AddSize.size45,
                                            width: AddSize.size45,
                                            decoration: BoxDecoration(
                                                color: AppTheme
                                                    .appPrimaryGreenColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: myWalletController
                                                        .model
                                                        .value
                                                        .data!
                                                        .walletTransactions![
                                                            index]
                                                        .status!
                                                        .isNotEmpty
                                                    ? const Icon(
                                                        Icons
                                                            .arrow_downward_outlined,
                                                        color: Colors.green,
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .arrow_upward_sharp,
                                                        color: Colors.red,
                                                      )),
                                          ),
                                          SizedBox(
                                            width: AddSize.size12,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                myWalletController
                                                    .model
                                                    .value
                                                    .data!
                                                    .walletTransactions![index]
                                                    .transactionDate
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize:
                                                            AddSize.font12),
                                              ),
                                              Text(
                                                myWalletController
                                                    .model
                                                    .value
                                                    .data!
                                                    .walletTransactions![index]
                                                    .remark
                                                    .toString(),
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
                                            ],
                                          ),
                                        ]),
                                        Text(
                                          '₹ ${myWalletController.model.value.data!.walletTransactions![index].amount.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AddSize.font14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ))
            : const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AddMoneyScreen.addMoneyScreen);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 60),
                primary: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "ADD TO WALLET",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: AppTheme.backgroundcolor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )),
        ),
      );
    });
  }

  listdata(image, title, color) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AddSize.padding10, vertical: AddSize.padding10),
      child: Column(
        children: [
          Container(
            height: AddSize.size30 * 2.3,
            width: AddSize.size30 * 2.0,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Image(
              image: AssetImage(image),
              height: AddSize.size30,
              width: AddSize.size30,
              fit: BoxFit.cover,
            )),
          ),
          SizedBox(
            height: AddSize.size5,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: AddSize.font14,
                color: AppTheme.blackcolor),
          ),
        ],
      ),
    );
  }
}
