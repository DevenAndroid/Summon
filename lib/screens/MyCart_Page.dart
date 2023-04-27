import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/MyOrder_Controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/cart_related_product_controller.dart';
import '../controller/category_controller.dart';
import '../controller/home_page_controller.dart';
import '../controller/location_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/near_store_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/single_store_controller.dart';
import '../controller/store_by_category_controller.dart';
import '../controller/store_controller.dart';

import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';
import 'coupons_screen.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final notificationController = Get.put(NotificationController());




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

    });
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Directionality(
      
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar:  AppBar(
            backgroundColor: Color(0xffFFFFFF),
            elevation: 0,
            leadingWidth: AddSize.size80,
            leading: Padding(
              padding: EdgeInsets.only(left: 33,right: 20),
              child: GestureDetector(
                child: Image.asset(
                  AppAssets.BACKICON,
                  height: AddSize.size30,
                ),
                onTap: () {

                },
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    //Get.toNamed(ChooseAddress.chooseAddressScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // InkWell(
                      //   onTap: () {},
                      //   child: const Icon(
                      //     Icons.location_on,
                      //     color: AppTheme.backgroundcolor,
                      //   ),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Cart",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                    ],
                  ),
                ),

              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: IconButton(
                  icon:
                  // Image.asset(
                  //   AppAssets.notification,
                  //   height: 22,
                  // ),
                  Padding(
                      padding: const EdgeInsets.only(
                          right: 1),
                      child:
                      Badge(
                        badgeStyle: const BadgeStyle(badgeColor: Color(0xffFFC529)),
                        badgeContent: Obx(() {
                          return Text(
                            notificationController
                                .isDataLoading.value
                                ? notificationController
                                .model.value.data!.count
                                .toString()
                                : "0",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: AddSize.font12),
                          );
                        }),
                        child:  Image.asset(
                          AppAssets.cartIcon),

                        ),
                      ), onPressed: () {  },),
              ),


            ],
          ),
          backgroundColor: Color(0xffFFFFFF),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: AddSize.size5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.backgroundcolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding16,
                                vertical: AddSize.padding16,
                               ),
                            child: Row(

                              children: [
                                Container(
                                  height: 100,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: AssetImage(AppAssets.pizza,),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AddSize.size30,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Red n hot pizza",
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xff000000)),),
                                          Icon(Icons.clear,color: Color(0xff000000),size: 20,),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Text("Spicy chicken, beef",
                                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff3F3B3B)),),
                                      SizedBox(height: 15,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("12 SR",
                                           style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff333333)),),
                                         Row(
                                           children: [
                                             Container(
                                               height: 32,
                                               width: 32,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: AppTheme.primaryColor
                                               ),
                                               child: Icon(Icons.add,color: Colors.white,),
                                             ),
                                             SizedBox(width: 7,),
                                             Text("02",
                                               style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color: Color(0xff000000)),),
                                             SizedBox(width: 7,),
                                             Image.asset(AppAssets.removeIcon,height: 30,width: 30,),
                                           ],
                                         ),

                                       ],
                                     ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40,),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(
                          height: 40,
                          width: 110,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              primary: AppTheme.primaryColor
                            ),
                              child:  Text("Apply",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:Colors.white),),),
                        ),
                        SizedBox(width: 120,),
                        Text("Promo Code",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Color(0xff7C7C7C)),),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .03,
                          vertical: height * .02,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Get.toNamed(
                                    CouponsScreen.couponsScreen);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: AddSize.size15,
                                    ),
                                   Row(
                                     children: [
                                       Text("Use Coupons",
                                           style: TextStyle(
                                               color:
                                               Color(0xff293044),
                                               fontSize: 15,
                                               fontWeight:
                                               FontWeight.w600)),
                                       SizedBox(width: 10,),

                                       const Image(
                                           height: 22,
                                           width: 28,
                                           image: AssetImage(AppAssets
                                               .couponIcon,)),
                                     ],
                                   ),

                                  ]),
                            ),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration:
                                    const ShapeDecoration(
                                        color: AppTheme
                                            .userActive,
                                        shape:
                                        CircleBorder()),
                                    child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: AppTheme
                                              .backgroundcolor,
                                          size: AddSize.size12,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                            "",
                                            style: TextStyle(
                                                color: AppTheme
                                                    .userActive,
                                                fontSize:
                                                AddSize
                                                    .font14,
                                                fontWeight:
                                                FontWeight
                                                    .w500)),
                                        Text(
                                            "",
                                            style: TextStyle(
                                                color: AppTheme
                                                    .userActive,
                                                fontSize:
                                                AddSize
                                                    .font12,
                                                fontWeight:
                                                FontWeight
                                                    .w500)),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {

                                    },
                                    style: TextButton.styleFrom(
                                        padding:
                                        EdgeInsets.zero),
                                    child: Text("Remove",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize:
                                            AddSize.font12,
                                            fontWeight:
                                            FontWeight
                                                .w500)),
                                  ),
                                ]),
                          ],
                        ),
                      )),
                  SizedBox(height: 20,),
                  details("Subtotal","56 SR","USD"),
                  Divider(
                    height: 10,
                    color: Color(0xffC0CCD4),
                    // color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  SizedBox(height: 5,),
                  details("Tax and Fees","45 SR","USD"),
                  Divider(
                    height: 10,
                    color: Color(0xffC0CCD4),
                    // color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  SizedBox(height: 5,),
                  details("Delivery","50 SR","USD"),
                  Divider(
                    height: 10,
                    color: Color(0xffC0CCD4),
                    // color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  SizedBox(height: 22,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Total",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff000000)),),
                        Flexible(child: Container()),
                        Text("(3 items)",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff494949)),),
                        SizedBox(width: 50,),
                        Text("59 SR",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff000000)),),
                        SizedBox(width: 10,),
                        Text("USD",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffADADB8)),),
                      ],
                    ),
                  ),
                  SizedBox(height: 60,),
                  ElevatedButton(
                      onPressed: () async {
                      },
                      style: ElevatedButton.styleFrom(
                          primary: AppTheme.primaryColor,
                          minimumSize: const Size(double.maxFinite, 60),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      child: const Text(
                        "Checkout",
                      )),
                  SizedBox(height: 80,),
                ],
              ),
            ),
          ),


      ),
    );
  }
  details(title, price, content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize:16,
                  fontWeight: FontWeight.w500)),
          Flexible(child: Container()),
          Text(price,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
        SizedBox(width: 5,),
          Text(content,
              style: TextStyle(
                  color: Color(0xffADADB8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }

}
