import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/main_home_controller.dart';
import 'package:fresh2_arrive/screens/notification_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';

AppBar buildAppBar(
  isProfilePage,
  int value,
  String profile,
) {
  final List<String> title = [
    "Search by category",
    "My Cart",
    "",
    "Stores",
    "My Profile"
  ];
  final controller = Get.put(MainHomeController());
  final profileController = Get.put(ProfileController());
  return AppBar(
    // toolbarHeight: 80,
    backgroundColor:
        controller.currentIndex.value != 0 ? Colors.transparent : Colors.white,
    elevation: 0,
    title: Obx(() {
      return controller.currentIndex.value == 0
          ? const Text(
              "Search by category",
              style: TextStyle(
                  color: Color(0xff423E5E),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            )
          : Text(
              title[controller.currentIndex.value],
              style: const TextStyle(
                  color: AppTheme.backgroundcolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            );
    }),
    leadingWidth: controller.currentIndex.value != 0 ? AddSize.size40 : AddSize.size20 * 1.6,
    leading: controller.currentIndex.value == 0
        ? Padding(
      padding: EdgeInsets.only(left: AddSize.padding10),
      child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
                AppAssets.back,
                height: AddSize.size20,
              )),
    )
        : Padding(
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
      if (controller.currentIndex.value != 0)
        Obx(() {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () async {
                Get.back();
                controller.onItemTap(4);
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
                      imageUrl: profileController.isDataLoading.value
                          ? (profileController.model.value.data!.profileImage ??
                                  "")
                              .toString()
                          : "",
                      height: 20,
                      width: 30,
                      errorWidget: (_, __, ___) => const SizedBox(),
                      placeholder: (_, __) => const SizedBox(),
                    )),
              ),
            ),
          );
        })
    ],
  );
}
/*
getUser() async {
  isLoggedIn.value = await isLogIn();
  //showToast(isLoggedIn.value.toString());
}*/
