
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/screens/AllCategories.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import '../controller/CartController.dart';
import '../controller/GetNearStoresOnMapController.dart';
import '../controller/HomePageController1.dart';
import '../controller/MyOrder_Controller.dart';
import '../controller/location_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/profile_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import 'Homepage_Screen.dart';
import 'Language_Change_Screen.dart';
import 'MapScreen_Page.dart';
import 'MyCart_Page.dart';
import 'SearchScreenData..dart';
import 'drawer.dart';

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

  final controller1 = Get.put(ProfileController());
  final scrollController = ScrollController();
  final getStoreOnMapController = Get.put(GetStoresOnMapController());

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      homeSearchController.page.value++;
      homeSearchController.searchingData(context: context);
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
            textDirection: locale==Locale('en','US')? TextDirection.ltr: TextDirection.rtl,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                key: controller.scaffoldKey,
                drawer: const CustomDrawer(),
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
                                  label: 'Categories'.tr,
                                ),
                                 BottomNavigationBarItem(
                                    icon:
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
                                    label: 'Cart'.tr),
                                 BottomNavigationBarItem(
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
                                          homeSearchController.searchingData(allowClear: true, context: context);
                                        },
                                        child: const ImageIcon(
                                          AssetImage(AppAssets.searchIcon),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    label: 'Search'.tr),
                                 BottomNavigationBarItem(
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 08),
                                      child: GestureDetector(
                                        onTap: () async {
                                          getStoreOnMapController.getStoresOnMap();
                                        },
                                        child: const ImageIcon(
                                          AssetImage(AppAssets.mapIcon),
                                          size: 18,

                                        ),
                                      ),
                                    ),
                                    label: 'Map'.tr),
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

                        AllCategories(),
                        MyCartPage(),
                        HomePageScreen(),
                        SearchScreenData(),
                        MapScreenPage(),

                      ],
                    );
                  }),
                )),
          ),


        );
  }
}
