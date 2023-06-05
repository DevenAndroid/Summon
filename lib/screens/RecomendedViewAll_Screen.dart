import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:get/get.dart';

import '../controller/ViewAllRecommendd_Controller.dart';
import '../controller/single_store_controller.dart';
import '../repositories/WishList_Repository.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';
import 'Language_Change_Screen.dart';

class ViewAllRecommendedPage extends StatefulWidget {
  const ViewAllRecommendedPage({Key? key}) : super(key: key);
  static var viewAllRecommendedPage = "/viewAllRecommendedPage";

  @override
  State<ViewAllRecommendedPage> createState() => _ViewAllRecommendedPageState();
}

class _ViewAllRecommendedPageState extends State<ViewAllRecommendedPage> {
  final viewAllRecommendedController = Get.put(ViewALlRecommendedController());
  final singleStoreController = Get.put(SingleStoreController());

  @override
  void initState() {
    super.initState();
    viewAllRecommendedController.getViewAllRecommendedData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return
      Directionality(
        textDirection: locale == Locale('en','US') ? TextDirection.ltr:TextDirection.rtl,
        child: Scaffold(
            appBar: backAppBar(title: "Recommended Products".tr, context: context),
            body: Obx(() {
              return viewAllRecommendedController.isDataLoading.value ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                  child: Column(
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: viewAllRecommendedController.model.value.data!
                              .length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisExtent: 230,
                              mainAxisSpacing: 20.0),
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return
                              Stack(
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        singleStoreController.storeId.value = viewAllRecommendedController.model.value.data![index].id.toString();

                                        Get.toNamed(StoreScreen.singleStoreScreen);

                            },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(

                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  //color: Colors.grey,
                                                  // borderRadius: BorderRadius.only(
                                                  //     topRight: Radius.circular(20),
                                                  //     topLeft: Radius.circular(20)),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(15),
                                                    topLeft: Radius.circular(15),
                                                  ),
                                                  child:
                                                  CachedNetworkImage(
                                                    imageUrl: viewAllRecommendedController
                                                        .model.value
                                                        .data![index].image
                                                        .toString(),
                                                    errorWidget: (_, __, ___) =>
                                                    const SizedBox(),
                                                    placeholder: (_, __) =>
                                                    const SizedBox(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //SizedBox(height: 5,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    viewAllRecommendedController.model
                                                        .value
                                                        .data![index].name
                                                        .toString(),
                                                    style: TextStyle(fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color(0xff08141B)),),
                                                  SizedBox(height: 8,),
                                                  Row(
                                                    children: [
                                                      Text("SR",
                                                        style: TextStyle(fontSize: 12,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color: Color(
                                                                0xff2C4D61)),),
                                                      SizedBox(width: 2,),
                                                      if(viewAllRecommendedController
                                                          .model.value
                                                          .data![index]
                                                          .variants != null)
                                                      Text(
                                                       "${viewAllRecommendedController
                                                            .model.value
                                                            .data![index]
                                                            .variants![0].price
                                                            .toString()}",
                                                        style: TextStyle(fontSize: 12,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color: Color(
                                                                0xff2C4D61)),),
                                                      SizedBox(width: 5,),
                                                      Text("25 mins •",
                                                        style: TextStyle(fontSize: 12,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color: Color(
                                                                0xff2C4D61)),),
                                                      SizedBox(width: 3,),
                                                      Icon(Icons.star,color: AppTheme.primaryColor, size:13,),
                                                      SizedBox(width: 1,),
                                                      Text(viewAllRecommendedController.model.value.data![index].avgRating.toString(), style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xffFE724C)),),
                                                      // Icon(Icons.star,color: AppTheme.primaryColor, size:15,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 20,
                                        right: 20,
                                        child: InkWell(
                                          onTap: () {
                                            print(
                                                "product wishlist id..${viewAllRecommendedController
                                                    .model.value.data![index].id
                                                    .toString()}");
                                            Map<String, dynamic> map = {};
                                            map['store_id'] =
                                                viewAllRecommendedController.model
                                                    .value.data![index].id
                                                    .toString();
                                            wishListRepo(store_id: map,
                                                context: context).then((value) {
                                              if (value.status == true) {
                                                showToast(value.message);
                                                viewAllRecommendedController
                                                    .getViewAllRecommendedData();
                                              }
                                            });
                                          },
                                          child: viewAllRecommendedController.model
                                .value.data![index].wishlist == true
                             ? Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      AppAssets.favIcon),
                                                )
                                            ),
                                          ): Container(
                                            height: 25,
                                            width: 25,
                                            decoration:BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:Colors.white
                                            ),
                                            child: Icon(Icons.favorite_border,color: AppTheme.primaryColor,size: 18,),
                                          ),
                                        )),
                                  ]);
                          }),
                      SizedBox(height: height * .05,)
                    ],
                  ),
                ),
              ):Center(child: CircularProgressIndicator());
            }),
    ),
      );

  }
}