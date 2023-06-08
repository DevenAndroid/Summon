import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/My_cart_controller.dart';
import '../controller/single_store_controller.dart';
import '../controller/store_by_category_controller.dart';
import '../controller/store_controller.dart';
import '../repositories/WishList_Repository.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'Language_Change_Screen.dart';

class StoreByCategoryListScreen extends StatefulWidget {
  const StoreByCategoryListScreen({Key? key}) : super(key: key);
  static var storeByCategoryScreen = "/storeByCategoryScreen";
  @override
  State<StoreByCategoryListScreen> createState() =>
      _StoreByCategoryListScreenState();
}

class _StoreByCategoryListScreenState extends State<StoreByCategoryListScreen> {
  final scrollController = ScrollController();
  final singleStoreController = Get.put(SingleStoreController());
  final nearStoreController = Get.put(StoreByCategoryController());
  final myCartController = Get.put(MyCartDataListController());
  final storeController = Get.put(StoreController());
  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      nearStoreController
          .getData(context: context)
          .then((value) => setState(() {}));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nearStoreController.getData(isFirstTime: true);
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


      return
        Directionality(
        textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "Store".tr, context: context),
          body: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16, vertical: AddSize.padding10),
              child: Column(
                children: [
                  Obx(() {
                    return nearStoreController.isDataLoading.value
                        ? nearStoreController.model.value.data!.isEmpty
                            ?  Center(
                                child: Text(
                                  'Store Not Available'.tr,
                                  style: TextStyle(
                                      color: AppTheme.blackcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            :
                    Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '(${nearStoreController.model.value.data!.length}) Stores Near You',
                                    style: const TextStyle(
                                        color: AppTheme.blackcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Obx(() {
                                    return  GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: nearStoreController.model.value.data!.length,
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

                                                      singleStoreController.storeId.value =
                                                          nearStoreController
                                                              .model.value.data![index].id
                                                              .toString();
                                                      Get.toNamed(
                                                          StoreScreen.singleStoreScreen);
                                                    },
                                                    child: Container(
                                                      decoration:BoxDecoration(
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
                                                                  imageUrl: nearStoreController.model.value
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
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  nearStoreController.model.value
                                                                      .data![index].name
                                                                      .toString(),
                                                                  style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Color(0xff08141B)),),
                                                                SizedBox(height: 8,),
                                                                FittedBox(
                                                                  child: Row(
                                                                    children: [
                                                                      Text("SR",
                                                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color: Color(
                                                                                0xff2C4D61)),), SizedBox(width: 3,),
                                                                      Text("${nearStoreController.model.value
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
                                                                      Text(nearStoreController.model.value
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
                                                                      Text(nearStoreController.model.value
                                                                          .data![index].avgRating
                                                                          .toString(), style:  GoogleFonts.ibmPlexSansArabic(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff2C4D61)),),
                                                                    ],
                                                                  ),
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
                                                        onTap: (){
                                                          print("product wishlist id..${nearStoreController.model.value.data![index].id.toString()}");
                                                          Map<String, dynamic> map={};
                                                          map['store_id'] = nearStoreController.model.value.data![index].id.toString();
                                                          wishListRepo(store_id: map,
                                                              context: context).then((value){
                                                            if(value.status==true){
                                                              showToast(value.message);
                                                             nearStoreController.getData();
                                                             setState(() {

                                                             });
                                                            }
                                                          });
                                                        },
                                                        child:
                                                        nearStoreController.model.value.data![index].wishlist! ? Container(
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
                                        });


                                  }),
                                  SizedBox(
                                    height: height * .04,
                                  )
                                ],
                              )
                        : const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: CircularProgressIndicator(
                              color: AppTheme.primaryColor,
                            ),
                          ));
                  }),
                  addHeight(30)
                ],
              ),
            ),
          ),
          // extendBody: true,
          // bottomNavigationBar: myCartController.isDataLoaded.value
          //     ? myCartController.model.value.data!.cartItems!.isNotEmpty
          //         ? addCartSection()
          //         : null
          //     : const SizedBox(),
        ),
      );


  }
}
