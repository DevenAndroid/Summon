import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/driver_screen/assigned_order.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivery_dashboard.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_delivery_details.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_information_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_registration.dart';
import 'package:fresh2_arrive/screens/help_center.dart';
import 'package:fresh2_arrive/screens/loginScreen.dart';
import 'package:fresh2_arrive/screens/my_address.dart';
import 'package:fresh2_arrive/screens/notification_screen.dart';
import 'package:fresh2_arrive/screens/order/myorder_screen.dart';
import 'package:fresh2_arrive/screens/privacy_policy.dart';
import 'package:fresh2_arrive/screens/refer_and_earn.dart';
import 'package:fresh2_arrive/screens/vendor_screen/bank_details.dart';
import 'package:fresh2_arrive/screens/vendor_screen/store_open_time_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_dashboard.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_orderList.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_information_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_products.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_registration.dart';
import 'package:fresh2_arrive/screens/vendor_screen/withdraw_money.dart';
import 'package:fresh2_arrive/screens/wallet_screen.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_theme.dart';
import 'driver_screen/withdraw_moeny.dart';

class CustomDrawer extends StatefulWidget {
  // final void Function(int index) onItemTapped;

  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final controller = Get.put(MainHomeController());
  final RxBool _isValue = false.obs;
  final RxBool _isValue1 = false.obs;
  var vendor = [
    'Dashboard',
    'Order',
    'Products',
    'Store open time',
    'Store setting',
    'Bank Details',
    'Earning'
  ];
  var vendorRoutes = [
    VenderDashboard.vendorDashboard,
    VendorOrderList.vendorOrderList,
    VendorProductScreen.vendorProductScreen,
    SetTimeScreen.setTimeScreen,
    VendorInformation.vendorInformation,
    BankDetailsScreen.bankDetailsScreen,
    WithDrawMoney.withDrawMoney,
  ];

  var driver = [
    'Dashboard',
    'Assigned Order',
    'Bank Details',
    'Earning',
    'Update driver setting',
  ];
  var driverRoutes = [
    DeliveryDashboard.deliveryDashboard,
    AssignedOrder.assignedOrder,
    BankDetailsScreen.bankDetailsScreen,
    DriverWithdrawMoney.driverWithdrawMoney,
    DriverInformation.driverInformation,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Drawer(
      child: Obx(() {
        return Container(
          color: AppTheme.backgroundcolor,
          // height: SizeConfig.heightMultiplier * 100,
          // width: SizeConfig.widthMultiplier! * 80,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: screenSize.height * 0.30,
                  width: screenSize.width * 0.8,
                  color: AppTheme.primaryColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.to(navigationPage.elementAt(_currentPage))
                          // Get.to(MyProfile());
                        },
                        child: Card(
                            elevation: 3,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                                margin: const EdgeInsets.all(4),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv00m-RB7TtdPHzzer0T4rTkqkbEkmov0wUg&usqp=CAU',
                                  height: screenSize.height * 0.12,
                                  width: screenSize.height * 0.12,
                                  errorWidget: (_, __, ___) => const SizedBox(),
                                  placeholder: (_, __) => const SizedBox(),
                                ))
                            // Image.network(
                            //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv00m-RB7TtdPHzzer0T4rTkqkbEkmov0wUg&usqp=CAU",
                            //   height: screenSize.height * 0.12,
                            //   width: screenSize.height * 0.12,
                            // )),
                            ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      const Text('Williams Jones',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      const Text('williamsjones@gmail.com',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                          // height: SizeConfig.heightMultiplier! * 1.8,
                          ),
                    ],
                  ),
                ),
                const SizedBox(
                    // height: SizeConfig.heightMultiplier! * .5,
                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _drawerTile(
                          active: true,
                          title: "My Orders",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_order),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () {
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   widget.onItemTapped(4);
                            // } else {
                            //   Get.back();
                            Get.toNamed(MyOrderScreen.myOrderScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "My Profile",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_profile),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   // Get.toNamed(
                            //   //   MyRouter.myOrdersScreen,
                            //   // );
                            // } else {
                            Get.back();
                            controller.onItemTap(4);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Notification",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_notification),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () {
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   // Get.toNamed(MyRouter.addressScreen);
                            // } else {
                            //   Get.back();
                            Get.toNamed(NotificationScreen.notificationScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "My Address",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_location),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () {
                            Get.toNamed(MyAddress.myAddressScreen);
                            // Get.back();
                            // widget.onItemTapped(1);
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Refer and Earn",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_refer),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   // Get.toNamed(MyRouter.notificationScreen,
                            //   //     arguments: [savedLanguage.toString()]);
                            // } else {
                            //   Get.back();
                            Get.toNamed(ReferAndEarn.referAndEarnScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "My Wallet",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_wallet),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(WalletScreen.myWalletScreen);
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Sign in as a vendor",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_vendor),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   Get.toNamed(MyRouter.subScriptionPlanScreen);
                            // } else {
                            //   Get.back();
                            Get.toNamed(
                              VendorRegistrationForm.vendorRegistrationForm,
                            );
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          _isValue.value = !_isValue.value;
                        },
                        child: ListTile(
                          minLeadingWidth: 30,
                          leading: const ImageIcon(
                            AssetImage(AppAssets.drawer_vendor),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          textColor: AppTheme.primaryColor,
                          iconColor: AppTheme.blackcolor,
                          title: const Text(
                            'Vendor',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.primaryColor),
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                _isValue.value = !_isValue.value;
                              },
                              child: Icon(_isValue.value == true
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_outlined)),
                        ),
                      ),
                      _isValue.value == true
                          ? Column(
                              children: List.generate(
                                  vendor.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          Get.toNamed(vendorRoutes[index]);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: AddSize.size5),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 65,
                                              ),
                                              Text(
                                                vendor[index],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        Colors.grey.shade500),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            )
                          : const SizedBox(),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Sign in as a driver",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_driver),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(DriverRegistrationScreen
                                .driverRegistrationScreen);
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   Get.toNamed(MyRouter.subScriptionPlanScreen);
                            // } else {
                            //   Get.back();
                            //   Get.toNamed(MyRouter.logInScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          _isValue1.value = !_isValue1.value;
                        },
                        child: ListTile(
                          minLeadingWidth: 30,
                          leading: const ImageIcon(
                            AssetImage(AppAssets.drawer_driver),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          textColor: AppTheme.primaryColor,
                          iconColor: AppTheme.blackcolor,
                          title: const Text(
                            'Driver',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.primaryColor),
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                _isValue1.value = !_isValue1.value;
                              },
                              child: Icon(_isValue1.value == true
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_outlined)),
                        ),
                      ),
                      _isValue1.value == true
                          ? Column(
                              children: List.generate(
                                  driver.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          Get.toNamed(driverRoutes[index]);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: AddSize.size5),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 65,
                                              ),
                                              Text(
                                                driver[index],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        Colors.grey.shade500),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            )
                          : const SizedBox(),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Privacy Policy",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_privacy),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   Get.toNamed(MyRouter.subScriptionPlanScreen);
                            // } else {
                            //   Get.back();
                            Get.toNamed(PrivacyPolicy.privacyPolicyScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Help Center",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_help),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            // SharedPreferences pref =
                            //     await SharedPreferences.getInstance();
                            // if (pref.getString('user') != null) {
                            //   Get.back();
                            //   Get.toNamed(MyRouter.subScriptionPlanScreen);
                            // } else {
                            //   Get.back();
                            Get.toNamed(HelpCenter.helpCenterScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Logout",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_logout),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.back();
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            Get.offAllNamed(LoginScreen.loginScreen);
                          }),
                    ],
                  ),
                ),

                // !isLogin ? const SizedBox.shrink() : const Divider(),
                // !isLogin
                //     ? const SizedBox.shrink()
                //     : _drawerTile(
                //         active: true,
                //         title: "Strings.deleteAccount",
                //         icon: const Icon(
                //           Icons.delete_outline_outlined,
                //           size: 22,
                //           color: AppTheme.userText,
                //         ),
                //         onTap: () async {
                //           // deleteUserAccountData(context).then((value) async {
                //           //   if (value.status == true) {
                //           //     _getClientInformation();
                //           //     Get.back();
                //           //     SharedPreferences preferences =
                //           //         await SharedPreferences.getInstance();
                //           //     await preferences.clear();
                //           //     Get.offAllNamed(MyRouter.logInScreen,
                //           //         arguments: ['mainScreen']);
                //           //   } else {
                //           //     showToast(value.message);
                //           //   }
                //           //   return null;
                //           // });
                //         }),
                // _drawerTile(
                //     active: true,
                //     title: "Strings.logOut",
                //     icon: const Icon(
                //       Icons.power_settings_new,
                //       size: 22,
                //       color: AppTheme.userText,
                //     ),
                //     onTap: () async {
                //       // _getClientInformation();
                //       // Get.back();
                //       // SharedPreferences preferences =
                //       //     await SharedPreferences.getInstance();
                //       // await preferences.clear();
                //       // Get.offAllNamed(MyRouter.logInScreen,
                //       //     arguments: ['mainScreen']);
                //     }),
              ],
            ),
          ),
        );
      }),
    );
  }

  //to get device Id
  // Future<void> _getClientInformation() async {
  //   ClientInformation? info;
  //   try {
  //     info = await ClientInformation.fetch();
  //   } on PlatformException {
  //     // print('Failed to get client information');
  //   }
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _clientInfo = info!;
  //   });
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('deviceId', _clientInfo!.deviceId.toString());
  // }

  Widget _drawerTile(
      {required bool active,
      required String title,
      required ImageIcon icon,
      required VoidCallback onTap}) {
    return ListTile(
      selectedTileColor: AppTheme.primaryColor,
      leading: icon,
      minLeadingWidth: 30,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: active ? onTap : null,
    );
  }
}
