import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/ViewAll_Popular_Repo.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/ViewAllRecommendd_Controller.dart';
import '../controller/ViewAll_PopularProduct_Controller.dart';
import '../controller/single_store_controller.dart';
import '../repositories/WishList_Repository.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';
import 'Language_Change_Screen.dart';

class ViewAllPopularPage extends StatefulWidget {
  const ViewAllPopularPage({Key? key}) : super(key: key);
  static var viewAllPopularPage = "/viewAllPopularPage";

  @override
  State<ViewAllPopularPage> createState() => _ViewAllPopularPageState();
}

class _ViewAllPopularPageState extends State<ViewAllPopularPage> {
  final viewAllPopularController = Get.put(ViewAllPopularController());
  final singleStoreController = Get.put(SingleStoreController());

  @override
  void initState() {
    super.initState();
    viewAllPopularController.getViewAllPopularData();
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
        textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "Popular Products".tr, context: context),
          body: Obx(() {
            return viewAllPopularController.isDataLoading.value ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                child: Column(
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: viewAllPopularController.model.value.data!
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
                                      singleStoreController.storeId.value = viewAllPopularController.model.value.data![index].id.toString();

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
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15),
                                                ),
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl: viewAllPopularController
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
                                                  viewAllPopularController.model
                                                      .value
                                                      .data![index].name
                                                      .toString(),
                                                  style: TextStyle(fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xff08141B)),),
                                                SizedBox(height: 8,),
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      Text("SR",
                                                        style: TextStyle(fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color: Color(
                                                                0xff2C4D61)),), SizedBox(width: 3,),
                                                      Text("${viewAllPopularController.model.value
                                                          .data![index].deliveryCharge
                                                          .toString()}",
                                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color: Color(
                                                                0xff2C4D61)),), SizedBox(width: 5,),
                                                      Icon(Icons.circle,size: 5,color: Color(
                                                          0xff2C4D61)),
                                                      SizedBox(width: 5,),
                                                      Text("KM",
                                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 12,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color: Color(
                                                                0xff2C4D61)),), SizedBox(width: 3,),
                                                      Text(viewAllPopularController.model.value
                                                          .data![index].distance
                                                          .toString(),

                                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color: Color(
                                                                0xff2C4D61)),),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.circle,size: 5,color: Color(
                                                          0xff2C4D61)),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.star,color: Color(0xff2C4D61), size: 17,), SizedBox(width: 3,),
                                                      Text(viewAllPopularController.model.value
                                                          .data![index].avgRating
                                                          .toString(), style:  GoogleFonts.ibmPlexSansArabic(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xff2C4D61)),),
                                                    ],
                                                  ),
                                                )
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
                                              "Store wishlist id..${viewAllPopularController
                                                  .model.value.data![index].id
                                                  .toString()}");
                                          Map<String, dynamic> map = {};
                                          map['store_id'] =
                                              viewAllPopularController.model
                                                  .value.data![index].id
                                                  .toString();
                                          wishListRepo(store_id: map,
                                              context: context).then((value) {
                                            if (value.status == true) {
                                              showToast(value.message);
                                              viewAllPopularController
                                                  .getViewAllPopularData();
                                            }
                                          });
                                        },
                                        child: viewAllPopularController.model
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