import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/AllCategories.dart';
import 'package:fresh2_arrive/screens/app_bar.dart';
import 'package:fresh2_arrive/screens/homepage.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/main_home_controller.dart';
import '../controller/profile_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
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
  final controller = Get.put(MainHomeController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xfff3f3f3),
          image: DecorationImage(
            image: AssetImage(
              AppAssets.background,
            ),
            alignment: Alignment.topRight,
            fit: BoxFit.contain,
          ),
        ),
        child: Obx(() {
          return Scaffold(
              backgroundColor: Colors.transparent,
              key: controller.scaffoldKey,
              drawer: const CustomDrawer(),
              appBar: controller.currentIndex.value != 2
                  ? buildAppBar(false, controller.currentIndex.value)
                  : AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leadingWidth: AddSize.size40,
                      leading: Padding(
                        padding: EdgeInsets.only(left: AddSize.padding10),
                        child: GestureDetector(
                          child: Image.asset(
                            AppAssets.drawerImage,
                            height: AddSize.size20,
                          ),
                          onTap: () {
                            controller.scaffoldKey.currentState!.openDrawer();
                          },
                        ),
                      ),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      ChooseAddress.chooseAddressScreen);
                                },
                                child: const Icon(
                                  Icons.location_on,
                                  color: AppTheme.backgroundcolor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.backgroundcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppTheme.backgroundcolor,
                                size: 30,
                              )
                            ],
                          ),
                          const Text(
                            "184 Main Collins Street Victoria 8007",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.backgroundcolor,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      actions: [
                        IconButton(
                          icon: Image.asset(
                            AppAssets.notification,
                            height: 22,
                          ),
                          onPressed: () {
                            Get.toNamed(NotificationScreen.notificationScreen);
                          },
                        ),
                        addWidth(10),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () async {
                              Get.back();
                              controller.onItemTap(4);
                              // SharedPreferences pref =
                              // await SharedPreferences.getInstance();
                              // if (pref.getString('user') != null) {
                              //   // ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
                              //
                              //   Get.off(CustomNavigationBar(
                              //     index: 4,
                              //   ));
                              // } else {
                              //   Get.toNamed(MyRouter.logInScreen);
                              // }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Container(
                                  height: 38,
                                  width: 38,
                                  clipBehavior: Clip.antiAlias,
                                  // margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    // color: Colors.brown
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv00m-RB7TtdPHzzer0T4rTkqkbEkmov0wUg&usqp=CAU',
                                    height: 20,
                                    width: 30,
                                    errorWidget: (_, __, ___) =>
                                        const SizedBox(),
                                    placeholder: (_, __) => const SizedBox(),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
              bottomNavigationBar: Obx(() {
                return BottomAppBar(
                    color: Colors.transparent,
                    shape: const CircularNotchedRectangle(),
                    clipBehavior: Clip.antiAlias,
                    child: Theme(
                        data: ThemeData(
                            splashColor: Colors.transparent,
                            bottomNavigationBarTheme:
                                const BottomNavigationBarThemeData(
                                    elevation: 0)),
                        child: BottomNavigationBar(
                            unselectedLabelStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                            selectedLabelStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.primaryColor),
                            items: [
                              const BottomNavigationBarItem(
                                icon: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 08,
                                  ),
                                  child: ImageIcon(
                                    AssetImage(AppAssets.categoryIcon),
                                    size: 18,
                                  ),
                                ),
                                label: 'Categories',
                              ),
                              const BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: ImageIcon(
                                      AssetImage(AppAssets.cart),
                                      size: 20,
                                    ),
                                  ),
                                  label: 'Cart'),
                              const BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 08,
                                    ),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      size: 22,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  label: ''),
                              BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 08,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: ImageIcon(
                                        AssetImage(AppAssets.store),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  label: 'Stores'),
                              const BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 08),
                                    child: ImageIcon(
                                      AssetImage(AppAssets.profile),
                                      size: 18,
                                    ),
                                  ),
                                  label: 'Profile'),
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
                      border: Border.all(
                          color: AppTheme.backgroundcolor, width: 2)),
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
                // FloatingActionButton(
                //   child: const Icon(
                //     Icons.home,
                //     size: 30,
                //   ),
                //   onPressed: () {
                //     controller.onItemTap(2);
                //   },
                // ),
              ),
              body: Center(
                child: Obx(() {
                  return IndexedStack(
                    index: controller.currentIndex.value,
                    children: const [
                      AllCategories(),
                      MyCartScreen(),
                      HomePage(),
                      StoreListScreen(),
                      MyProfileScreen(),
                    ],
                  );
                }),
              ));
        }));
  }
}
