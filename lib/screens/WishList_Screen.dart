import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/ViewAll_Popular_Repo.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:get/get.dart';

import '../controller/GetWishListProduct_controller.dart';
import '../controller/ViewAllRecommendd_Controller.dart';
import '../controller/ViewAll_PopularProduct_Controller.dart';
import '../controller/single_store_controller.dart';
import '../repositories/WishList_Repository.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);
  static var wishListScreen = "/wishListScreen";

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final getWishListProductController = Get.put(GetWishListProduct());
  final singleStoreController = Get.put(SingleStoreController());


  @override
  void initState() {
    super.initState();
    getWishListProductController.getWishListProduct();
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
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "Favorites", context: context),
          body: Obx(() {
            return getWishListProductController.isDataLoading.value ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                child: Column(
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: getWishListProductController.model.value.data!.reviews!
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
                                      singleStoreController.storeId.value= getWishListProductController.model.value.data!.reviews![index].id.toString();
                                      print(getWishListProductController.model.value.data!.reviews![index].id.toString());
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
                                                  imageUrl: getWishListProductController
                                                      .model.value
                                                      .data!.reviews![index].image
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
                                                  getWishListProductController.model
                                                      .value
                                                      .data!.reviews![index].name
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
                                                    Text(getWishListProductController.model.value.data!.reviews![index].avgRating.toString(), style: TextStyle(
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
                                              "Store wishlist id..${getWishListProductController
                                                  .model.value.data!.reviews![index].id
                                                  .toString()}");
                                          Map<String, dynamic> map = {};
                                          map['store_id'] =
                                              getWishListProductController.model
                                                  .value.data!.reviews![index].id
                                                  .toString();
                                          wishListRepo(store_id: map,
                                              context: context).then((value) {
                                            if (value.status == true) {
                                              showToast(value.message);
                                              getWishListProductController
                                                  .getWishListProduct();
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    AppAssets.favIcon),
                                              )
                                          ),
                                        )
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