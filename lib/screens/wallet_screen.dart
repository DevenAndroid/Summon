import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/add_money.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/myWallet_controller.dart';
import '../controller/profile_controller.dart';
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
  final profileController = Get.put(ProfileController());
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                            [

                              GestureDetector(
                                  child: listdata(
                                      walletModel[0].image,
                                      walletModel[0].value.toString(),
                                      walletModel[0].color),
                                  onTap: () {
                                    log("user type${walletModel[0].key}");
                                    myWalletController.userType.value = walletModel[0].key;
                                    if(myWalletController.userType.value=="A"){
                                      myWalletController.userType.value = "";
                                    }
                                    print("user type....${walletModel[0].key}");
                                    myWalletController.getWalletData();
                                    setState(() {});
                                  }),
                              if(profileController.model.value.data!.asVendorVerified == true)
                              GestureDetector(
                                  child: listdata(
                                      walletModel[1].image,
                                      walletModel[1].value.toString(),
                                      walletModel[1].color),
                                  onTap: () {
                                    log("user type${walletModel[1].key}");
                                    myWalletController.userType.value = walletModel[1].key;
                                    if(myWalletController.userType.value=="V"){
                                      myWalletController.userType.value = "";
                                    }
                                    print("user type....${walletModel[1].key}");
                                    myWalletController.getWalletData();
                                    setState(() {});
                                  }),
                              if(profileController.model.value.data!.asDriverVerified == true)
                              GestureDetector(
                                  child: listdata(
                                      walletModel[2].image,
                                      walletModel[2].value.toString(),
                                      walletModel[2].color),
                                  onTap: () {
                                    log("user type${walletModel[2].key}");
                                    myWalletController.userType.value = walletModel[2].key;
                                    if(myWalletController.userType.value=="A"){
                                      myWalletController.userType.value = "";
                                    }
                                    print("user type${walletModel[2].key}");
                                    myWalletController.getWalletData();
                                    setState(() {});
                                  }),
                              GestureDetector(
                                  child: listdata(
                                      walletModel[3].image,
                                      walletModel[3].value.toString(),
                                      walletModel[3].color),
                                  onTap: () {
                                    log("user type${walletModel[3].key}");
                                    myWalletController.userType.value = walletModel[3].key;
                                    if(myWalletController.userType.value=="C"){
                                      myWalletController.userType.value = "";
                                    }
                                    print("user type${walletModel[3].key}");
                                    myWalletController.getWalletData();
                                    setState(() {});
                                  }),
                            ]
                            //     profileController.model.value.data!.asVendorVerified == true && profileController.model.value.data!.asDriverVerified == true ?
                            //     List.generate(walletModel.length, (index) {
                            //   return GestureDetector(
                            //       child: listdata(
                            //           walletModel[index].image,
                            //           walletModel[index].value.toString(),
                            //         walletModel[index].color),
                            //       onTap: () {
                            //         log("user type${walletModel[index].key}");
                            //         myWalletController.userType.value = walletModel[index].key;
                            //         if(myWalletController.userType.value=="A"){
                            //           myWalletController.userType.value = "";
                            //         }
                            //         print("user type${walletModel[index].key}");
                            //         myWalletController.getWalletData();
                            //         setState(() {});
                            //       });
                            // }):profileController.model.value.data!.asVendorVerified == true?
                            //     List.generate(walletModel.where((element) => element.value !="Vendor").length, (index) {
                            //       return GestureDetector(
                            //           child: listdata(
                            //               walletModel.where((element) => element.value !="Vendor").toList()[index].image,
                            //               walletModel.where((element) => element.value !="Vendor").toList()[index].value.toString(),
                            //               walletModel.where((element) => element.value !="Vendor").toList()[index].color),
                            //           onTap: () {
                            //             log("user type${walletModel.where((element) => element.value !="Vendor").toList()[index].key}");
                            //             myWalletController.userType.value = walletModel.where((element) => element.value !="Vendor").toList()[index].key;
                            //             if(myWalletController.userType.value=="A"){
                            //               myWalletController.userType.value = "";
                            //             }
                            //             print("user type${walletModel.where((element) => element.value !="Vendor").toList()[index].key}");
                            //             myWalletController.getWalletData();
                            //             setState(() {});
                            //           });
                            //     })
                            //         :profileController.model.value.data!.asDriverVerified == true?
                            //     List.generate(walletModel.where((element) => element.value !="Driver").length, (index) {
                            //       return GestureDetector(
                            //           child: listdata(
                            //               walletModel.where((element) => element.value !="Driver").toList()[index].image,
                            //               walletModel.where((element) => element.value !="Driver").toList()[index].value.toString(),
                            //               walletModel.where((element) => element.value !="Driver").toList()[index].color),
                            //           onTap: () {
                            //             log("user type${walletModel.where((element) => element.value !="Driver").toList()[index].key}");
                            //             myWalletController.userType.value = walletModel.where((element) => element.value !="Driver").toList()[index].key;
                            //             if(myWalletController.userType.value=="A"){
                            //               myWalletController.userType.value = "";
                            //             }
                            //             print("user type${walletModel.where((element) => element.value !="Driver").toList()[index].key}");
                            //             myWalletController.getWalletData();
                            //             setState(() {});
                            //           });
                            //     }) :
                            //     List.generate(walletModel.where((element) => element.value =="All" ||element.value =="Customer").length, (index) {
                            //       return GestureDetector(
                            //           child: listdata(
                            //               walletModel.where((element) => element.value =="All" ||element.value =="Customer").toList()[index].image,
                            //               walletModel.where((element) => element.value =="All" ||element.value =="Customer").toList()[index].value.toString(),
                            //               walletModel.where((element) => element.value =="All" ||element.value =="Customer").toList()[index].color),
                            //           onTap: () {
                            //             log("user type${walletModel.where((element) => element.value =="All" ||element.value =="Customer").toList()[index].key}");
                            //             myWalletController.userType.value = walletModel.where((element) => element.value =="All" ||element.value =="Customer").toList()[index].key;
                            //             if(myWalletController.userType.value=="A"){
                            //               myWalletController.userType.value = "";
                            //             }
                            //             print("user type${walletModel.where((element) => element.value =="All" ||element.value =="Customer").toList()[index].key}");
                            //             myWalletController.getWalletData();
                            //             setState(() {});
                            //           });
                            //     })

                            ),
                      ),
                      myWalletController
                          .model.value.data!.walletTransactions!.isNotEmpty ?
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
                                                color: myWalletController
                                                    .model
                                                    .value
                                                    .data!
                                                    .walletTransactions![
                                                index]
                                                    .status == "Credit" || myWalletController
                                                    .model
                                                    .value
                                                    .data!
                                                    .walletTransactions![
                                                index]
                                                    .status == "Earn" || myWalletController
                                                    .model
                                                    .value
                                                    .data!
                                                    .walletTransactions![
                                                index]
                                                    .status == "Refund" ? AppTheme
                                                    .appPrimaryGreenColor:AppTheme
                                                    .appPrimaryPinkColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: myWalletController
                                                        .model
                                                        .value
                                                        .data!
                                                        .walletTransactions![
                                                            index]
                                                        .status == "Credit" || myWalletController
                                                    .model
                                                    .value
                                                    .data!
                                                    .walletTransactions![
                                                index]
                                                    .status == "Earn" || myWalletController
                                                    .model
                                                    .value
                                                    .data!
                                                    .walletTransactions![
                                                index]
                                                    .status == "Refund"
                                                    ? const Icon(
                                                        Icons.arrow_downward_sharp,
                                                        color: Colors.green,
                                                      )
                                                    : const Icon(
                                                        Icons.arrow_upward_sharp,
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
                                          '₹${myWalletController.model.value.data!.walletTransactions![index].amount.toString()}',
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
                      ):
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            AddSize.padding20 * 3),
                        child: Text("Data not Available",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                height: 1.5,
                                fontWeight:
                                FontWeight.w500,
                                fontSize:
                                AddSize.font14,
                                color: AppTheme
                                    .blackcolor)),
                      ),
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
