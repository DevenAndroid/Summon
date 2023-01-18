import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/main_home_controller.dart';
import 'package:fresh2_arrive/screens/notification_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../routers/my_router.dart';
import '../screens/custum_bottom_bar.dart';
import '../widgets/dimensions.dart';

AppBar buildAppBar(
  isProfilePage,
  int value,
) {
  final List<String> title = [
    "Search by category",
    "My Cart",
    "",
    "Stores",
    "My Profile"
  ];
  final controller = Get.put(MainHomeController());
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Obx(() {
      return Text(
        title[controller.currentIndex.value],
        style: const TextStyle(
            color: AppTheme.backgroundcolor,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      );
    }),
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
                  errorWidget: (_, __, ___) => const SizedBox(),
                  placeholder: (_, __) => const SizedBox(),
                )),
          ),
        ),
      )
    ],
  );
}
/*
getUser() async {
  isLoggedIn.value = await isLogIn();
  //showToast(isLoggedIn.value.toString());
}*/
