import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:get/get.dart';
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
import 'notification_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final homeSearchController = Get.put(HomePageController());
  final myCartController = Get.put(MyCartDataListController());
  final relatedCartController = Get.put(CartRelatedProductController());
  final viewAllController = Get.put(CategoryController());
  final locationController = Get.put(LocationController());
  final controller = Get.put(MainHomeController());
  final homeController = Get.put(HomePageController());
  final nearStoreController = Get.put(NearStoreController());
  final singleStoreController = Get.put(StoreController());
  final myOrderController = Get.put(MyOrderController());
  final storeCategoryController = Get.put(StoreByCategoryController());
  final profileController = Get.put(ProfileController());
  final addToCartQtyController = TextEditingController();
  final storeController = Get.put(SingleStoreController());
  final notificationController = Get.put(NotificationController());

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
    });
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF6F6F6),
          appBar:  AppBar(
            backgroundColor: Color(0xffF6F6F6),
            elevation: 0,
            leadingWidth: AddSize.size80,
            leading: Padding(
              padding: EdgeInsets.only(left: 33,right: 20),
              child: GestureDetector(
                child: Image.asset(
                  AppAssets.homeIcon,
                  height: AddSize.size30,
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
                      const Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.primaryColor,
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
                        badgeStyle: const BadgeStyle(badgeColor: AppTheme.primaryColor),
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
                          size: 40,
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
          body: RefreshIndicator(
            onRefresh: () async {
              nearStoreController.isPaginationLoading.value = true;
              nearStoreController.loadMore.value = true;
              await nearStoreController.getData(isFirstTime: true);
              profileController.getData();
              homeController.getData();
              myOrderController.getMyOrder();
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //physics: ScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    SizedBox(
                      height: height * .07,
                      child: TextField(
                        maxLines: 3,
                        // controller:
                        // homeSearchController.searchController,
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
                              horizontal: width * .02,vertical: height * .02),
                          hintText: 'Find for food or restaurant...',
                          hintStyle: TextStyle(
                              fontSize: AddSize.font14,
                              color: Color(0xff9DA4BB),
                              fontWeight: FontWeight.w400),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Get.to(const SearchScreenData());

                            },
                            icon: const Icon(
                              Icons.search_rounded,
                              color: Color(0xff8990A7),
                              size: 30,
                            ),
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {
                              // Get.to(const SearchScreenData());

                            },
                            icon: const Icon(
                              Icons.place_rounded,
                              color: Color(0xffD3D1D8),
                              size: 30,
                            ),
                          ),
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
                          3,
                              (index) => Container(
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
                                child: CachedNetworkImage(
                                  imageUrl: "https://t4.ftcdn.net/jpg/01/45/12/63/360_F_145126390_5nZU2QWeRcFMZZNEM82oiLH7DOqwk17f.jpg",
                                  errorWidget: (_, __, ___) =>
                                  const SizedBox(),
                                  placeholder: (_, __) =>
                                  const SizedBox(),
                                  fit: BoxFit.cover,
                                ),
                              ))),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Obx(() {
                      return Center(
                        child: DotsIndicator(
                          dotsCount: 3,
                          position: sliderIndex.value,
                          decorator: DotsDecorator(
                            color: Colors
                                .grey.shade300, // Inactive color
                            activeColor: AppTheme.primaryColor,
                            size: const Size.square(12),
                            activeSize: const Size.square(12),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: height * .01,
                    ),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index){
                            return SizedBox(
                              width: 100,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 140,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)

                                    ),
                                    child:  Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                            image: AssetImage(AppAssets.burger,),
                                          ),
                                        ),
                                        Text("Donut",
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Color(0xff67666D)),),
                                      ],
                                    ),
                                  ),

                                ],
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
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xff000000)),),
                        Text("View All",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color:AppTheme.primaryColor),),
                      ],
                    ),

                    SizedBox(
                      height: height * .01,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 10.0),
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return
                            Stack(
                              children:[
                                Column(
                              children: [
                                Container(
                                height: 150,
                                width: 190,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  image: DecorationImage(
                                    image: AssetImage(AppAssets.foodIMG,),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                  ),
                                SizedBox(height: 5,),
                                Column(

                                  children: [
                                    Text("Chinese Hut Fast Food And Biryani",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Color(0xff08141B)),),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Text("15 SR • 25 mins •",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff2C4D61)),),
                                        SizedBox(width: 3,),
                                        Text("★4.5",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffFE724C)),),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                          ),
                                Positioned(
                                    top:20,
                                    right: 20,
                                    child: Container(

                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppAssets.favIcon),
                                          )
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
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xff000000)),),
                        Flexible(child: Container()),
                        Text("View All",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color:AppTheme.primaryColor),),
                        SizedBox(
                          height: height * .01,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index){
                            return SizedBox(
                              width: 200,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 190,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                      image: DecorationImage(
                                        image: AssetImage(AppAssets.foodIMG,),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Chinese Hut Fast Food And Biryani",
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Color(0xff08141B)),),
                                        SizedBox(height: 8,),
                                        Row(
                                          //mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("15 SR • 25 mins •",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff2C4D61)),),
                                            SizedBox(width: 3,),
                                            Text("★4.5",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffFE724C)),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          )


      ),
    );
  }

}
