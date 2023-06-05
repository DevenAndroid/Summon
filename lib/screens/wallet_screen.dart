
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/myWallet_controller.dart';
import '../controller/profile_controller.dart';
import '../resources/app_assets.dart';
import 'Language_Change_Screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);
  static var myWalletScreen = "/myWalletScreen";

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final myWalletController = Get.put(MyWalletController());
  final profileController = Get.put(ProfileController());

  final scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      myWalletController.getWalletData().then((value) => setState(() {}));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      myWalletController.getWalletData(isFirstTime: true);
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Directionality(
        textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "My Wallet".tr, context: context),
          body: myWalletController.isDataLoading.value
              ? SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding12),
                    child: Column(
                      children: [
                        Row(

                          children: [
                            Expanded(
                              child: SizedBox(

                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  color: AppTheme.primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [

                                          Row(
                                            children: [
                                              Text(
                                                "SR",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: AddSize.font24,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                '${myWalletController.model.value.data!.totalAmount.toString()}',
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
                                            ],
                                          ),
                                           Text(
                                             "Total Balance".tr,
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
                                        Image(
                                          image: const AssetImage(
                                              AppAssets.earnIcon),
                                          height: AddSize.size40,
                                          width: AddSize.size40,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),

                        myWalletController
                                .model.value.data!.walletTransactions!.isNotEmpty
                            ? Container(
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
                                    itemCount: myWalletController.isPaginationLoading.value ? myWalletController.model.value
                                        .data!.walletTransactions!.length:myWalletController.model.value
                                        .data!.walletTransactions!.length+1,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          if(myWalletController.isPaginationLoading.value)
                                          {
                                            return walletTransactions(index, context);
                                          }else{
                                            if(index <myWalletController.model.value
                                                .data!.walletTransactions!
                                                .length){
                                              return walletTransactions(index, context);
                                            }
                                            else{
                                              return Center(child:CircularProgressIndicator(),);
                                            }
                                          }
                                        }))
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding20 * 3),
                                child: Text("Data not Available".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            height: 1.5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font14,
                                            color: AppTheme.blackcolor)),
                              ),
                      ],
                    ),
                  ))
              : const Center(child: CircularProgressIndicator()),

        ),
      );
    });
  }

  Padding walletTransactions(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AddSize.padding16, vertical: AddSize.padding12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  height: AddSize.size45,
                  width: AddSize.size45,
                  decoration: BoxDecoration(
                      color: myWalletController.model.value.data!
                                      .walletTransactions![index].status ==
                                  "Credit" ||
                              myWalletController.model.value.data!
                                      .walletTransactions![index].status ==
                                  "Earn" ||
                              myWalletController.model.value.data!
                                      .walletTransactions![index].status ==
                                  "Refund"
                          ? AppTheme.appPrimaryGreenColor
                          : AppTheme.appPrimaryPinkColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: myWalletController.model.value.data!
                                      .walletTransactions![index].status ==
                                  "Credit" ||
                              myWalletController.model.value.data!
                                      .walletTransactions![index].status ==
                                  "Earn" ||
                              myWalletController.model.value.data!
                                      .walletTransactions![index].status ==
                                  "Refund"
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myWalletController.model.value.data!
                          .walletTransactions![index].transactionDate
                          .toString(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.w300,
                          fontSize: AddSize.font12),
                    ),
                    Text(
                      myWalletController
                          .model.value.data!.walletTransactions![index].remark
                          .toString(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          fontSize: AddSize.font14),
                    ),
                  ],
                ),
              ]),
             Row(
               children: [
                 Text(
                   "SR",
                   style: GoogleFonts.ibmPlexSansArabic(
                       color: Color(0xff423E5E),
                       fontSize: 14,
                       fontWeight: FontWeight.w600),
                 ),
                 SizedBox(width: 5,),
                 Text(
                   "${myWalletController
                       .model.value.data!.walletTransactions![index].amount
                       .toString()}+",
                   style: GoogleFonts.ibmPlexSansArabic(
                       color: Color(0xff423E5E),
                       fontSize: 14,
                       fontWeight: FontWeight.w600),
                 ),
               ],
             ),
            ],
          ),
        ],
      ),
    );
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
