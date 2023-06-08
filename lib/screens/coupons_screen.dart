import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fresh2_arrive/controller/coupon_controller.dart';
import 'package:fresh2_arrive/repositories/apply_coupons_repository.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../controller/CartController.dart';
import '../controller/My_cart_controller.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';
import 'Language_Change_Screen.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);
  static var couponsScreen = "/couponsScreen";

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final controller = Get.put(MainHomeController());
  final couponController = Get.put(CouponController());
  final cartController = Get.put(MyCartController());
  final myCartController = Get.put(MyCartDataListController());
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    couponController.getData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
          appBar: backAppBar(title: "Coupons".tr, context: context),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * .01),
                child: Column(
                  children: [
                    Obx(() {
                      return couponController.isDataLoading.value
                          ? couponController.model.value.data!.isEmpty ?
                           Center(
                             child: Text("! Coupons Not Available".tr,
                              style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                fontWeight:
                                FontWeight.w500,
                                fontSize: AddSize.font16),),
                           )
                      :ListView.builder(
                              itemCount:
                                  couponController.model.value.data!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: height * .01),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)),
                                    // height: height * .23,
                                    child: Stack(
                                      children: [
                                        Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.04,),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Html(data:couponController
                                                      .model
                                                      .value
                                                      .data![index]
                                                      .couponDetails
                                                      .toString()),
                                                  SizedBox(
                                                    height: height * .005,
                                                  ),
                                                  const Divider(),
                                                  SizedBox(
                                                    height: height * .005,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      DottedBorder(
                                                          borderType:
                                                              BorderType.RRect,
                                                          dashPattern: const [5, 5],
                                                          color:
                                                              AppTheme.primaryColor,
                                                          strokeWidth: 1.5,
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: Color(0xffFFF1ED)),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          width *
                                                                              0.03,
                                                                      vertical:
                                                                          height *
                                                                              .005),
                                                              child: Text(
                                                                couponController
                                                                    .model
                                                                    .value
                                                                    .data![index]
                                                                    .couponCode
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline5!
                                                                    .copyWith(
                                                                        color: AppTheme
                                                                            .blackcolor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize: 16),
                                                              ),
                                                            ),
                                                          )),
                                                      GestureDetector(
                                                        onTap: () {
                                                          applyCoupons(couponCode: couponController
                                                              .model
                                                              .value
                                                              .data![index]
                                                              .couponCode
                                                              .toString(), context: context).
                                                          then((value){
                                                            showToast(value.message);
                                                            if(value.status == true){
                                                              myCartController.getAddToCartList();
                                                              cartController.getCartData();
                                                              controller.onItemTap(1);
                                                             Get.back();
                                                              setState(() {

                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          "APPLY".tr,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline5!
                                                              .copyWith(
                                                                  color: AppTheme.primaryColor,
                                                                  fontWeight:
                                                                      FontWeight.w500,
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * .03,
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Positioned(
                                          top: AddSize.size20,
                                          left: AddSize.size20,
                                          child:  Container(
                                          height: height * .04,
                                          width: width * .10,
                                          decoration:
                                          const ShapeDecoration(
                                              color: Color(0xffFFF1ED),
                                              shape:
                                              CircleBorder()),
                                          child: Center(
                                              child: Image(
                                                  height: height * .02,
                                                  width: width * .04,
                                                  image: const AssetImage(
                                                      AppAssets.couponIcon,))),
                                        ),)
                                      ],
                                    ));
                              })
                          : const Center(
                              child: CircularProgressIndicator(
                              color: AppTheme.primaryColor,
                            ));
                    }),
                    addHeight(5),
                  ],
                ),
              ))),
    );
  }
}
