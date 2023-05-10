import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/screens/AllCategories.dart';
import 'package:fresh2_arrive/screens/SetPassword_Screen.dart';
import 'package:fresh2_arrive/screens/app_bar.dart';
import 'package:fresh2_arrive/screens/homepage.dart';
import 'package:fresh2_arrive/screens/order/myorder_screen.dart';
import 'package:fresh2_arrive/screens/storeListScreen.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import '../controller/CartController.dart';
import '../controller/HomePageController1.dart';
import '../controller/MyOrder_Controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/location_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/store_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'Categories_Screen.dart';
import 'Homepage_Screen.dart';
import 'MapScreen_Page.dart';
import 'MyCart_Page.dart';
import 'SearchScreenData..dart';
import 'drawer.dart';
import 'myProfile.dart';
import 'my_cart_screen.dart';
import 'notification_screen.dart';
import 'order/choose_address.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);
  static var customNavigationBar = "/customNavigationBar";

  @override
  CustomNavigationBarState createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  final myOrderController = Get.put(MyOrderController());
  final homeSearchController = Get.put(HomePageController1());
  final controller = Get.put(MainHomeController());
  final profileController = Get.put(ProfileController());
  final locationController = Get.put(LocationController());
  final myCartController = Get.put(MyCartController());
  final notificationController = Get.put(NotificationController());
  final storeController = Get.put(StoreController());
  final controller1 = Get.put(ProfileController());
  final scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      homeSearchController.page.value++;
      homeSearchController.searchingData();
      print("call");
    }else{
      print("dont call");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationController.checkGps(context);
    homeSearchController.searchingData();
    scrollController.addListener(_scrollListener);
   // myCartController.getAddToCartList();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Container(
        decoration:  BoxDecoration(
          color: Color(0xffFFFFFF),
          image: DecorationImage(
            image: AssetImage(
              AppAssets.storeBG,
            ),
           opacity: .8,
            alignment: Alignment.topRight,
            fit: BoxFit.contain,
          ),
        ),
        child:

            Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                key: controller.scaffoldKey,
                drawer: const CustomDrawer(),
                // appBar: controller.currentIndex.value != 2
                //     ? controller.currentIndex.value == 0
                //         ?
                //         // category app bar
                //         buildAppBar(
                //             false, controller.currentIndex.value, "".toString())
                //         : buildAppBar(
                //             false,
                //             controller.currentIndex.value,
                //             profileController.isDataLoading.value
                //                 ? (profileController
                //                             .model.value.data!.profileImage ??
                //                         "")
                //                     .toString()
                //                 : "")
                //     :
                // AppBar(
                //         backgroundColor: Color(0xffF6F6F6),
                //         elevation: 0,
                //         leadingWidth: AddSize.size80,
                //         leading: Padding(
                //           padding: EdgeInsets.only(left: 33,right: 20),
                //           child: GestureDetector(
                //             child: Image.asset(
                //               AppAssets.homeIcon,
                //               height: AddSize.size30,
                //             ),
                //             onTap: () {
                //               controller.scaffoldKey.currentState!.openDrawer();
                //               profileController.getData();
                //             },
                //           ),
                //         ),
                //         title: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             InkWell(
                //               onTap: () {
                //                 //Get.toNamed(ChooseAddress.chooseAddressScreen);
                //               },
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   // InkWell(
                //                   //   onTap: () {},
                //                   //   child: const Icon(
                //                   //     Icons.location_on,
                //                   //     color: AppTheme.backgroundcolor,
                //                   //   ),
                //                   // ),
                //                   const SizedBox(
                //                     width: 10,
                //                   ),
                //                   const Text(
                //                     "Home",
                //                     style: TextStyle(
                //                         fontSize: 18,
                //                         color: AppTheme.primaryColor,
                //                         fontWeight: FontWeight.w500),
                //                   ),
                //                   const SizedBox(
                //                     width: 5,
                //                   ),
                //
                //                 ],
                //               ),
                //             ),
                //             // Text(
                //             //   locationController.locality.value.toString(),
                //             //   style: const TextStyle(
                //             //       fontSize: 14,
                //             //       color: AppTheme.backgroundcolor,
                //             //       fontWeight: FontWeight.w400),
                //             // ),
                //           ],
                //         ),
                //         actions: [
                //           IconButton(
                //             icon:
                //             // Image.asset(
                //             //   AppAssets.notification,
                //             //   height: 22,
                //             // ),
                //             Padding(
                //                 padding: const EdgeInsets.only(
                //                     right: 10.0),
                //                 child:
                //                 Badge(
                //                   badgeStyle: const BadgeStyle(badgeColor: AppTheme.primaryColor),
                //                   badgeContent: Obx(() {
                //                     return Text(
                //                       notificationController
                //                           .isDataLoading.value
                //                           ? notificationController
                //                           .model.value.data!.count
                //                           .toString()
                //                           : "0",
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontSize: AddSize.font12),
                //                     );
                //                   }),
                //                   child: const ImageIcon(
                //                     AssetImage(AppAssets.bagIcon),
                //                     size: 40,
                //                     color: Colors.black,
                //                   ),
                //                 )),
                //             onPressed: () {
                //               Get.toNamed(NotificationScreen.notificationScreen);
                //               //Get.to(SetPasswordScreen());
                //             },
                //           ),
                //           addWidth(20),
                //           // Padding(
                //           //   padding: const EdgeInsets.only(left:22),
                //           //   child: GestureDetector(
                //           //     onTap: () async {
                //           //       Get.toNamed(MyProfileScreen.myProfileScreen);
                //           //     },
                //           //     child: CircleAvatar(
                //           //       backgroundColor: Colors.white,
                //           //       radius: 20,
                //           //       child: Container(
                //           //           height: 38,
                //           //           width: 38,
                //           //           clipBehavior: Clip.antiAlias,
                //           //           // margin: EdgeInsets.all(1),
                //           //           decoration: BoxDecoration(
                //           //             borderRadius: BorderRadius.circular(50),
                //           //             // color: Colors.brown
                //           //           ),
                //           //           child: Obx(() {
                //           //             return(profileController.isDataLoading.value
                //           //                 ? (profileController.model.value.data!
                //           //                 .profileImage ??
                //           //                 "")
                //           //                 .toString()
                //           //                 : "").isNotEmpty ? CachedNetworkImage(
                //           //               fit: BoxFit.cover,
                //           //               imageUrl:
                //           //                   profileController.isDataLoading.value
                //           //                       ? profileController.model.value
                //           //                           .data!.profileImage!
                //           //                       : '',
                //           //               height: AddSize.size30,
                //           //               width: AddSize.size30,
                //           //               errorWidget: (_, __, ___) =>
                //           //                   const SizedBox(),
                //           //               placeholder: (_, __) => const SizedBox(),
                //           //             ):SizedBox.shrink();
                //           //           })),
                //           //     ),
                //           //   ),
                //           // )
                //         ],
                //       ),
                bottomNavigationBar: Obx(() {
                  return BottomAppBar(
                      color: Colors.transparent,
                      shape: const CircularNotchedRectangle(),
                      clipBehavior: Clip.hardEdge,
                      child: Theme(
                          data: ThemeData(
                              splashColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              bottomNavigationBarTheme:
                                  const BottomNavigationBarThemeData(
                                      // backgroundColor: Colors.transparent,
                                      elevation: 0)),
                          child: BottomNavigationBar(
                              unselectedLabelStyle: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                              selectedLabelStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.primaryColor),
                              items: [
                                 BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 08,
                                    ),
                                    child: GestureDetector(
                                      onTap: (){

                                      },
                                      child: const ImageIcon(
                                        AssetImage(AppAssets.categoryIcon),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  label: 'Categories',
                                ),
                                 BottomNavigationBarItem(
                                    icon:
                                    // Padding(
                                    //   padding: EdgeInsets.symmetric(
                                    //     vertical: 08,
                                    //   ),
                                    //   child: ImageIcon(
                                    //     AssetImage(AppAssets.cartImage),
                                    //     size: 18,
                                    //   ),
                                    // ),
                                    Padding(
                                        padding:  EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Badge(
                                          badgeStyle: const BadgeStyle(badgeColor: AppTheme.blackcolor),
                                          badgeContent: Obx(() {
                                            return Text(
                                              myCartController.sum.value
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: AddSize.font12),
                                            );
                                          }),
                                          child: GestureDetector(
                                            onTap: ()async{
                                             await myCartController.getCartData();
                                            },
                                            child: const ImageIcon(
                                              AssetImage(AppAssets.cartImage),
                                              size: 20,
                                            ),
                                          ),
                                        )),
                                    // icon: Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: ImageIcon(
                                    //     AssetImage(AppAssets.cart),
                                    //     size: 20,
                                    //   ),
                                    // ),
                                    label: 'Cart'),
                                const BottomNavigationBarItem(
                                    icon: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 08,
                                        ),
                                        child: null),
                                    label: ''),
                                BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 08,
                                      ),
                                      child: GestureDetector(
                                        onTap: (){
                                          //homeSearchController.load=false.obs;
                                          homeSearchController.searchingData(allowClear: true);
                                        },
                                        child: const ImageIcon(
                                          AssetImage(AppAssets.searchIcon),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    label: 'Search'),
                                 BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 08),
                                      child: GestureDetector(
                                        onTap: () async {
                                           // await profileController.getData();
                                        },
                                        child: const ImageIcon(
                                          AssetImage(AppAssets.mapIcon),
                                          size: 18,

                                        ),
                                      ),
                                    ),
                                    label: 'Map'),
                              ],
                              type: BottomNavigationBarType.fixed,
                              currentIndex: controller.currentIndex.value,
                              selectedItemColor: AppTheme.primaryColor,
                              iconSize: 40,
                              onTap: controller.onItemTap,
                              elevation: 5)));
                }),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Visibility(
                  visible: !keyboardIsOpened,
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(30),

                    ),
                    child: GestureDetector(
                      child: const Center(
                        child: Icon(
                          Icons.home,
                          size: 30,
                          color: AppTheme.backgroundcolor,
                        ),
                      ),
                      onTap: () {
                        controller.onItemTap(2);
                      },
                    ),
                  ),
                ),
                body: Center(
                  child: Obx(() {
                    return IndexedStack(
                      index: controller.currentIndex.value,
                      children: const [
                        //AllCategories(),
                        AllCategories(),
                        MyCartPage(),
                        HomePageScreen(),
                        SearchScreenData(),
                        // StoreListScreen(),
                        MapScreenPage(),

                      ],
                    );
                  }),
                )),
          ),


        );
  }
}
