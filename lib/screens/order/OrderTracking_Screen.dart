import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/Language_Change_Screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/MyOrder_Details_Controller.dart';
import '../../resources/app_assets.dart';
import '../../widgets/dimensions.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);
  static var orderTrackingScreen = "/orderTrackingScreen";

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen>
    with SingleTickerProviderStateMixin {
  final myOrderDetailsController = Get.put(MyOrderDetailsController());
  bool value = false;
  TabController? tabController;

  @override
  void initState() {
     }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

      return
        Directionality(
        textDirection: locale==Locale('en','US') ? TextDirection.ltr :TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "Order Activity".tr, context: context),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: AddSize.size10,
                  ),
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     reverse: true,
                  //     physics: BouncingScrollPhysics(),
                  //     itemCount:3,
                  //     // myOrderDetailsController
                  //     //     .model.value.data!.orderActivity!.length,
                  //     itemBuilder: (context, i) {
                  //       return
                  //         IntrinsicHeight(
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //
                  //               Flexible(
                  //                 child: Column(
                  //                   children: [
                  //                     Container(
                  //                       height: AddSize.size20,
                  //                       width: AddSize.size20,
                  //                       decoration: BoxDecoration(
                  //                           borderRadius:
                  //                           BorderRadius.circular(50),
                  //                           color: Color(0xff7A7676)),
                  //                     ),
                  //                     Expanded(
                  //                       child: Container(
                  //                         width: width * 0.007,
                  //                         height: 2,
                  //                         decoration: BoxDecoration(
                  //                           color: i == 0
                  //                               ? Colors.transparent
                  //                               : Color(0xff7A7676),
                  //                           borderRadius: BorderRadius.all(
                  //                               Radius.circular(5)),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: AddSize.size50,
                  //                 width: AddSize.size50,
                  //                 child: ClipRRect(
                  //                   borderRadius: BorderRadius.circular(50),
                  //                   child: CachedNetworkImage(
                  //                     imageUrl: "https://media.istockphoto.com/id/1287828123/photo/modern-courier-delivery-at-home-shopogolic-and-online-shopping.jpg?s=612x612&w=0&k=20&c=vbSWNHGhmPMjJE7IL-mMKY1MTJXiJ9qMffVdyGerstM=",
                  //                     errorWidget: (_, __, ___) => SizedBox(),
                  //                     placeholder: (_, __) => SizedBox(),
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //               ),
                  //               addWidth(10),
                  //               Expanded(
                  //                 flex:10,
                  //                 child: SizedBox(
                  //                   width: double.maxFinite,
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                     MainAxisAlignment.start,
                  //                     crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
                  //                     children: [
                  //                       // SizedBox(height: AddSize.size10,),
                  //
                  //                       Text(
                  //                         "order Placed",
                  //                         style: GoogleFonts.poppins(
                  //                             fontWeight: FontWeight.w600,
                  //                             color: Color(0xff262F33),
                  //                             fontSize: AddSize.font16),
                  //                       ),
                  //                       Text(
                  //                         "We have received your order on\n 01-June-2023",
                  //                         style: GoogleFonts.poppins(
                  //                             fontWeight: FontWeight.w300,
                  //                             color:Color(0xff48585E),
                  //                             fontSize: AddSize.font12),
                  //                       ),
                  //
                  //                       SizedBox(height: 20,)
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ]),
                  //       );
                  //
                  //     }),
                  IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                children: [
                                  Container(
                                    height: AddSize.size20,
                                    width: AddSize.size20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        color: AppTheme.primaryColor),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width * 0.007,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color:  AppTheme.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                           Container(
                             height: 50,
                             width: 50,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               color: AppTheme.primaryColor
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: ImageIcon(
                                 AssetImage(
                                     AppAssets
                                     .T1),
                                  color: Colors.white,
                                 size: 17,
                               ),
                             ),
                           ),
                          addWidth(10),
                          Expanded(
                            flex:8,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: AddSize.size10,),

                                  Text(
                                    "order Placed".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff262F33),
                                        fontSize: AddSize.font16),
                                  ),
                                  Text(
                                    "We have received your order on\n 01-June-2023".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        color:Color(0xff48585E),
                                        fontSize: AddSize.font12),
                                  ),

                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                children: [
                                  Container(
                                    height: AddSize.size20,
                                    width: AddSize.size20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        color:AppTheme.primaryColor),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width * 0.007,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primaryColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ImageIcon(
                                AssetImage(
                                    AppAssets
                                        .T1),
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                          addWidth(10),
                          Expanded(
                            flex:8,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: AddSize.size10,),

                                  Text(
                                    "Order Confirmed".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff262F33),
                                        fontSize: AddSize.font16),
                                  ),
                                  Text(
                                    "We have received your order on\n 01-June-2023".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        color:Color(0xff48585E),
                                        fontSize: AddSize.font12),
                                  ),

                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                children: [
                                  Container(
                                    height: AddSize.size20,
                                    width: AddSize.size20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        color: Color(0xff7CB543)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width * 0.007,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color:Color(0xff7A7676),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff7CB543)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ImageIcon(
                                AssetImage(
                                    AppAssets
                                        .T1),
                              color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                          addWidth(10),
                          Expanded(
                            flex:8,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: AddSize.size10,),

                                  Text(
                                    "Order Processed".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff262F33),
                                        fontSize: AddSize.font16),
                                  ),
                                  Text(
                                    "We have received your order on\n 01-June-2023".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        color:Color(0xff48585E),
                                        fontSize: AddSize.font12),
                                  ),

                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                children: [
                                  Container(
                                    height: AddSize.size20,
                                    width: AddSize.size20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        color: Color(0xffD9D9D9)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width * 0.007,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color:Color(0xffD9D9D9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AddSize.size50,
                            width: AddSize.size50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: "https://media.istockphoto.com/id/1287828123/photo/modern-courier-delivery-at-home-shopogolic-and-online-shopping.jpg?s=612x612&w=0&k=20&c=vbSWNHGhmPMjJE7IL-mMKY1MTJXiJ9qMffVdyGerstM=",
                                errorWidget: (_, __, ___) => SizedBox(),
                                placeholder: (_, __) => SizedBox(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          addWidth(10),
                          Expanded(
                            flex:8,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: AddSize.size10,),

                                  Text(
                                    "Ready to Ship".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffCACACA),
                                        fontSize: AddSize.font16),
                                  ),
                                  Text(
                                    "We have received your order on\n 01-June-2023".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        color:Color(0xffCACACA),
                                        fontSize: AddSize.font12),
                                  ),

                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                children: [
                                  Container(
                                    height: AddSize.size20,
                                    width: AddSize.size20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        color: Color(0xffD9D9D9)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width * 0.007,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color:Color(0xffD9D9D9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AddSize.size50,
                            width: AddSize.size50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: "https://media.istockphoto.com/id/1287828123/photo/modern-courier-delivery-at-home-shopogolic-and-online-shopping.jpg?s=612x612&w=0&k=20&c=vbSWNHGhmPMjJE7IL-mMKY1MTJXiJ9qMffVdyGerstM=",
                                errorWidget: (_, __, ___) => SizedBox(),
                                placeholder: (_, __) => SizedBox(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          addWidth(10),
                          Expanded(
                            flex:8,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: AddSize.size10,),

                                  Text(
                                    "Out for Delivery".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffCACACA),
                                        fontSize: AddSize.font16),
                                  ),
                                  Text(
                                    "We have received your order on\n 01-June-2023".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        color:Color(0xffCACACA),
                                        fontSize: AddSize.font12),
                                  ),

                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),

          // bottomNavigationBar:  Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 10),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       ElevatedButton(
          //           onPressed: () async {
          //
          //           },
          //           style: ElevatedButton.styleFrom(
          //               primary: Colors.black,
          //               minimumSize: const Size(double.maxFinite, 60),
          //               elevation: 0,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(8)),
          //               textStyle:  GoogleFonts.poppins(
          //                   color: Colors.white,
          //                   fontSize: 18, fontWeight: FontWeight.w600)),
          //           child: const Text(
          //             "CANCEL ORDER",
          //           )),
          //       SizedBox(height: height * .03,),
          //       ElevatedButton(
          //           onPressed: () async {
          //
          //           },
          //           style: ElevatedButton.styleFrom(
          //               primary: AppTheme.primaryColor,
          //               minimumSize: const Size(double.maxFinite, 60),
          //               elevation: 0,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(8)),
          //               textStyle:  GoogleFonts.poppins(
          //                   color: Colors.white,
          //                   fontSize: 18, fontWeight: FontWeight.w600)),
          //           child: const Text(
          //             "ORDER READY",
          //           )),
          //       SizedBox(height: height * .03,),
          //       ElevatedButton(
          //           onPressed: () async {
          //
          //           },
          //           style: ElevatedButton.styleFrom(
          //               primary: Colors.green,
          //               minimumSize: const Size(double.maxFinite, 60),
          //               elevation: 0,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(8)),
          //               textStyle:  GoogleFonts.poppins(
          //                   color: Colors.white,
          //                   fontSize: 18, fontWeight: FontWeight.w600)),
          //           child: const Text(
          //             "PICKUP COMPLETED",
          //           )),
          //     ],
          //   ),
          // ),
        ),
      );
  }

}
