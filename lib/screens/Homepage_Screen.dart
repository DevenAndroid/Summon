import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/store_by_category.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/HomePageController1.dart';
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
import '../repositories/WishList_Repository.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';
import 'SearchScreenData..dart';
import 'notification_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final homeSearchController = Get.put(HomePageController1());
  final myCartController = Get.put(MyCartDataListController());
  final relatedCartController = Get.put(CartRelatedProductController());
  final viewAllController = Get.put(CategoryController());
  final locationController = Get.put(LocationController());
  final controller = Get.put(MainHomeController());
  final homeController1 = Get.put(HomePageController1());
  final nearStoreController = Get.put(NearStoreController());
  final singleStoreController = Get.put(StoreController());
  final myOrderController = Get.put(MyOrderController());
  final storeCategoryController = Get.put(StoreByCategoryController());
  final profileController = Get.put(ProfileController());
  final addToCartQtyController = TextEditingController();
  final storeController = Get.put(SingleStoreController());
  final notificationController = Get.put(NotificationController());

  int currentIndex = -1;

  final scrollController = ScrollController();
  RxDouble sliderIndex = (0.0).obs;

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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      scrollController.addListener(_scrollListener);
      homeController1.getHomePageData();
     // homeSearchController.getData(isFirstTime:true);

    });
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          // backgroundColor: Colors.grey.shade50,
        backgroundColor: Color(0xffF6F6F6),
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Color(0xffF6F6F6),
            elevation: 0,
            leadingWidth: AddSize.size80,
            leading: Padding(
              padding: EdgeInsets.only(left: 33, right: 20),
              child: GestureDetector(
                child: Image.asset(
                    AppAssets.homeIcon,
                    height: 50,
                    width: 50,
                    opacity: AlwaysStoppedAnimation(.80)
                ),
                onTap: () {
                  controller.scaffoldKey.currentState!.openDrawer();
                  profileController.getData();
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
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.primaryColor.withOpacity(.80),

                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 5,
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
                          right: 10.0),
                      child:
                      Badge(
                        badgeStyle: BadgeStyle(
                            badgeColor: AppTheme.primaryColor.withOpacity(.80)),
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
                        child: const ImageIcon(
                          AssetImage(AppAssets.bagIcon),
                          size: 45,
                          color: Colors.black,

                        ),
                      )),
                  onPressed: () {
                    Get.toNamed(NotificationScreen.notificationScreen);
                    //Get.to(SetPasswordScreen());
                  },
                ),
              ),


            ],
          ),
          body: Obx(() {
            return RefreshIndicator(
              onRefresh: () async {
                nearStoreController.isPaginationLoading.value = true;
                nearStoreController.loadMore.value = true;
                await nearStoreController.getData(isFirstTime: true);
                profileController.getData();
                homeController1.getHomePageData();
                myOrderController.getMyOrder();
              },
              child:  homeController1.isDataLoading.value ?  SingleChildScrollView(
                scrollDirection: Axis.vertical,
                //physics: ScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding15),
                  child:
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * .02,
                      ),
                      SizedBox(
                        height: height * .07,
                        child: TextField(
                          maxLines: 3,
                          controller:
                          homeSearchController.searchController,
                          style: const TextStyle(fontSize: 17),
                          // textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => {},
                          decoration: InputDecoration(
                            filled: true,

                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8))),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: width * .02,
                                vertical: height * .02),
                            hintText: 'Find for food or restaurant...',
                            hintStyle: TextStyle(
                                fontSize: AddSize.font14,
                                color: Color(0xff9DA4BB),
                                fontWeight: FontWeight.w400),
                            suffixIcon: IconButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus!
                                    .unfocus();
                                print(homeSearchController
                                    .searchController);
                                Get.toNamed(
                                    SearchScreenData.searchScreen);

                              },
                              icon: const Icon(
                                Icons.search_rounded,
                                color: Color(0xff8990A7),
                                size: 30,
                              ),
                            ),
                            // prefixIcon: IconButton(
                            //   onPressed: () {
                            //     // Get.to(const SearchScreenData());
                            //
                            //   },
                            //   icon: const Icon(
                            //     Icons.place_rounded,
                            //     color: Color(0xffD3D1D8),
                            //     size: 30,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),

                      CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            onPageChanged: (value, _) {
                              sliderIndex.value = value.toDouble();
                            },
                            autoPlayCurve: Curves.ease,
                            height: height * .20),
                        items: List.generate(
                            homeController1.model.value.data!.sliderData!
                                .length,
                                (index) =>
                                Container(
                                    width: width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: width * .01),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: AppTheme.backgroundcolor),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      child:
                                      CachedNetworkImage(
                                        imageUrl: homeController1.model.value
                                            .data!.sliderData![index].image
                                            .toString(),
                                        errorWidget: (_, __, ___) =>
                                        const SizedBox(),
                                        placeholder: (_, __) =>
                                        const SizedBox(),
                                        fit: BoxFit.cover,
                                      ),
                                    ))),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      InkWell(
                        onTap: () {
                          controller.onItemTap(0);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Text("View All",
                              style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor.withOpacity(
                                      .80)),),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 100,
                                child: InkWell(
                                  onTap: () {
                                    currentIndex = index;
                                    setState(() {

                                      });
                                    storeCategoryController
                                          .storeId.value = homeController1.model.value.data!.latestCategory![index].id
                                          .toString();
                                      log("category id is ..${storeCategoryController.storeId.value}");
                                      Get.toNamed(StoreByCategoryListScreen.storeByCategoryScreen);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 140,
                                      width: 85,
                                      decoration: BoxDecoration(
                                          color: currentIndex != index ? Colors
                                              .white : Color(0xffFE724C)
                                              .withOpacity(.80),
                                          borderRadius: BorderRadius.circular(
                                              20)

                                      ),
                                      child: Column(

                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                color: Colors.white
                                              ),
                                                child:  Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: homeController1.model.value
                                                        .data!.latestCategory![index].image
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
                                          SizedBox(height: 5,),
                                          Text(homeController1.model.value
                                              .data!.latestCategory![index].name
                                              .toString(),
                                            style: TextStyle(fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: currentIndex == index
                                                    ? Colors.white
                                                    : Color(0xff67666D)),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recomended for you",
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000)),),
                          Text("View All",
                            style: TextStyle(fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primaryColor.withOpacity(
                                    .80)),),
                        ],
                      ),

                      SizedBox(
                        height: height * .01,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: homeController1.model.value.data!.recommendedProduct!.length,
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
                                    Container(
                                      decoration:BoxDecoration(
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
                                                  imageUrl: homeController1.model.value
                                                      .data!.recommendedProduct![index].image
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
                                                  homeController1.model.value
                                                      .data!.recommendedProduct![index].name
                                                      .toString(),
                                                  style: TextStyle(fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xff08141B)),),
                                                SizedBox(height: 8,),
                                                Row(
                                                  children: [
                                                    Text(homeController1.model.value
                                                        .data!.recommendedProduct![index].variants![0].price
                                                        .toString(),
                                                      style: TextStyle(fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          color: Color(
                                                              0xff2C4D61)),), SizedBox(width: 5,),Text("25 mins •",
                                                      style: TextStyle(fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          color: Color(
                                                              0xff2C4D61)),),
                                                    SizedBox(width: 3,),
                                                    Text("★4.5", style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color(0xffFE724C)),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 20,
                                        right: 20,
                                        child: InkWell(
                                        onTap: (){
                                          print("product wishlist id..${homeController1.model.value.data!.recommendedProduct![index].id.toString()}");
                                          Map<String, dynamic> map={};
                                          map['product_id'] = homeController1.model.value.data!.recommendedProduct![index].id.toString();
                                          wishListRepo(productId: map,
                                              context: context).then((value){
                                            if(value.status==true){
                                              showToast(value.message);
                                              homeController1.getHomePageData();
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
                                          ),
                                        )),
                                  ]);
                          }),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Popular Products",
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000)),),
                          Flexible(child: Container()),
                          Text("View All",
                            style: TextStyle(fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primaryColor),),
                          SizedBox(
                            height: height * .01,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: homeController1.model.value.data!.popularProduct!.length,
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
                                    Container(
                                      decoration:BoxDecoration(
                                        color: Color(0xffFFFFFF).withOpacity(.30),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(

                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                //color: Colors.grey,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    topLeft: Radius.circular(20)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                ),
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl: homeController1.model.value
                                                      .data!.popularProduct![index].image
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
                                                  homeController1.model.value
                                                      .data!.popularProduct![index].name
                                                      .toString(),
                                                  style: TextStyle(fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xff08141B)),),
                                                SizedBox(height: 8,),
                                                Row(
                                                  children: [
                                                    Text(homeController1.model.value
                                                        .data!.popularProduct![index].variants![0].price
                                                        .toString(),
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
                                                    Text("★4.5", style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color(0xffFE724C)),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 20,
                                        right: 20,
                                        child: GestureDetector(
                                          onTap: (){
                                            print("product wishlist id..${homeController1.model.value.data!.popularProduct![index].id.toString()}");
                                            Map<String, dynamic> map={};
                                            map['product_id'] = homeController1.model.value.data!.popularProduct![index].id.toString();
                                            wishListRepo(productId: map,
                                                context: context).then((value){
                                              if(value.status==true){
                                                showToast(value.message);
                                                homeController1.getHomePageData();
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
                                          ),
                                        )),
                                  ]);
                          }),
                      SizedBox(height: height * .01,),
                    ],
                  ) ,
                ),
              ): Center(child: CircularProgressIndicator(
                color: AppTheme.primaryColor,)),
            );
          })


      ),
    );
  }

}
