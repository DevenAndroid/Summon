import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fresh2_arrive/controller/coupon_controller.dart';
import 'package:fresh2_arrive/repositories/apply_coupons_repository.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);
  static var couponsScreen = "/couponsScreen";

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final controller = Get.put(MainHomeController());
  final couponController = Get.put(CouponController());
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
    return Scaffold(
        appBar: backAppBar(title: "Coupons", context: context),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * .01),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      maxLines: 1,
                      controller: codeController,
                      style: const TextStyle(fontSize: 17),
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) => {},
                      decoration: InputDecoration(
                          filled: true,
                          suffixIcon: TextButton(
                              onPressed: () {
                                applyCoupons(couponCode: codeController.text
                                    .toString(), context: context).
                                then((value){
                                  showToast(value.message);
                                  if(value.status == true){
                                    myCartController.getAddToCartList();
                                    controller.onItemTap(1);
                                    Get.back();
                                  }
                                });
                              },
                              child: Text(
                                "Apply  ".toUpperCase(),
                                style: TextStyle(
                                    fontSize: AddSize.font16,
                                    color: AppTheme.blackcolor,
                                    fontWeight: FontWeight.w500),
                              )),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding20,
                              vertical: AddSize.padding20),
                          hintText: 'Enter coupon code',
                          hintStyle: TextStyle(
                              fontSize: AddSize.font14,
                              color: AppTheme.blackcolor,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Obx(() {
                    return couponController.isDataLoading.value
                        ? couponController.model.value.data!.isEmpty ?
                         Text("Coupons Not Available!",
                          style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(
                            fontWeight:
                            FontWeight.w500,
                            fontSize: AddSize.font16),)
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
                                                                  color: AppTheme
                                                                      .newprimaryColor),
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
                                                            controller.onItemTap(1);
                                                            Get.back();
                                                          }
                                                        });
                                                      },
                                                      child: Text(
                                                        "APPLY",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                color: AppTheme
                                                                    .userActive,
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
                                        right: AddSize.size20,
                                        child:  Container(
                                        height: height * .04,
                                        width: width * .10,
                                        decoration:
                                        const ShapeDecoration(
                                            color: AppTheme
                                                .newprimaryColor,
                                            shape:
                                            CircleBorder()),
                                        child: Center(
                                            child: Image(
                                                height: height * .02,
                                                width: width * .04,
                                                image: const AssetImage(
                                                    AppAssets
                                                        .coupons_image))),
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
            )));
  }
}
