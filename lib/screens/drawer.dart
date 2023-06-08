import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/Language_Change_Screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivery_dashboard.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivery_order_history.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_information_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_registration.dart';
import 'package:fresh2_arrive/screens/help_center.dart';
import 'package:fresh2_arrive/screens/myProfile.dart';
import 'package:fresh2_arrive/screens/my_address.dart';
import 'package:fresh2_arrive/screens/notification_screen.dart';
import 'package:fresh2_arrive/screens/order/myorder_screen.dart';
import 'package:fresh2_arrive/screens/privacy_policy.dart';
import 'package:fresh2_arrive/screens/vendor_screen/bank_details.dart';
import 'package:fresh2_arrive/screens/vendor_screen/store_open_time_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_dashboard.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_orderList.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_information_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_products.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_registration.dart';
import 'package:fresh2_arrive/screens/vendor_screen/withdraw_money.dart';
import 'package:fresh2_arrive/screens/wallet_screen.dart';
import 'package:fresh2_arrive/screens/welcome_screen.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/MyOrder_Controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/profile_controller.dart';
import '../resources/app_theme.dart';
import 'WishList_Screen.dart';
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
  final profileController = Get.put(ProfileController());
  final myOrderController = Get.put(MyOrderController());
  final RxBool _isValue = false.obs;
  final RxBool _isValue1 = false.obs;
  var vendor = [
    'Dashboard'.tr,
    'Order'.tr,
    'Products'.tr,
    'Store open time'.tr,
    'Vendor Information'.tr,
    'Bank Details'.tr,
    'Withdraw'.tr
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
    'Dashboard'.tr,
    'Order History'.tr,
    'Bank Details'.tr,
    'Withdraw'.tr,
    'Driver Information'.tr,
  ];
  var driverRoutes = [
    DeliveryDashboard.deliveryDashboard,
    DeliveredOrderHistory.orderDeliveryHistory,
    BankDetailsScreen.bankDetailsScreen,
    DriverWithdrawMoney.driverWithdrawMoney,
    DriverInformation.driverInformation,
  ];

  ClientInformation? _clientInfo;
  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _clientInfo = info!;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', _clientInfo!.deviceId.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Directionality(
      textDirection: locale==Locale('en','US')? TextDirection.ltr: TextDirection.rtl,
      child: Drawer(
        child: Obx(() {
          return Container(
            color: AppTheme.backgroundcolor,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    height: screenSize.height * 0.30,
                    width: screenSize.width,
                    color: AppTheme.primaryColor.withOpacity(.80),
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
                                  child:
                                  CachedNetworkImage(
                                    imageUrl:
                                        profileController.isDataLoading.value
                                            ? (profileController.model.value.data!
                                                        .profileImage ??
                                                    "")
                                                .toString()
                                            : "",
                                    height: screenSize.height * 0.12,
                                    width: screenSize.height * 0.12,
                                    errorWidget: (_, __, ___) => const SizedBox(),
                                    placeholder: (_, __) => const SizedBox(),
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Text(
                            profileController.isDataLoading.value
                                ? (profileController.model.value.data!.name ?? "")
                                    .toString()
                                : "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        Text(
                            profileController.isDataLoading.value
                                ? (profileController.model.value.data!.email ??
                                        "")
                                    .toString()
                                : "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                            title: "My Orders".tr,
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_order),
                              size: 22,
                              color: AppTheme.primaryColor,
                            ),
                            onTap: () {
                              myOrderController.getMyOrder();
                             // Get.back();
                              Get.toNamed(MyOrderScreen.myOrderScreen);
                              // controller.onItemTap(4);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "My Profile".tr,
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_profile),
                              size: 22,
                              color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.toNamed(MyProfileScreen.myProfileScreen);
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Notification".tr,
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
                            title: "My Address".tr,
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
                        // _drawerTile(
                        //     active: true,
                        //     title: "Wishlist",
                        //     icon:  ImageIcon(
                        //       Icon(Icons.favorite_border),
                        //       size: 22,
                        //       // color: AppTheme.primaryColor,
                        //     ),
                        //     onTap: () async {
                        //       // SharedPreferences pref =
                        //       //     await SharedPreferences.getInstance();
                        //       // if (pref.getString('user') != null) {
                        //       //   Get.back();
                        //       //   // Get.toNamed(MyRouter.notificationScreen,
                        //       //   //     arguments: [savedLanguage.toString()]);
                        //       // } else {
                        //       //   Get.back();
                        //       Get.toNamed(ReferAndEarn.referAndEarnScreen);
                        //       // }
                        //     }),
                        Padding(
                          padding: const EdgeInsets.only(right: 15,top: 15,bottom: 12,left: 15),
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(WishListScreen.wishListScreen);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(height: 10,),
                                Icon(Icons.favorite_border, color: AppTheme.primaryColor,),
                                SizedBox(width: 25,),
                                Text("Wishlist".tr, style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppTheme.primaryColor,fontSize: 15
                                ),),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15,top: 15,bottom: 12,left: 15),
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(LanguageChangeScreen.languageChangeScreen);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(height: 10,),
                                Icon(Icons.public, color: AppTheme.primaryColor,),
                                SizedBox(width: 25,),
                                Text("Language".tr, style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppTheme.primaryColor,fontSize: 15
                                ),),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "My Wallet".tr,
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
                        profileController.isDataLoading.value
                            ? profileController.model.value.data!.isVendor ==
                                    false
                                ? _drawerTile(
                                    active: true,
                                    title: "Sign in as a vendor".tr,
                                    icon: const ImageIcon(
                                      AssetImage(AppAssets.drawer_vendor),
                                      size: 22,
                                      color: AppTheme.primaryColor,
                                    ),
                                    onTap: () async {
                                      Get.toNamed(
                                        VendorRegistrationForm
                                            .vendorRegistrationForm,
                                      );
                                      // }
                                    })
                                : profileController
                                            .model.value.data!.asVendorVerified ==
                                        true
                                    ? Column(
                                        children: [
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
                                                AssetImage(
                                                    AppAssets.drawer_vendor),
                                                size: 22,
                                                color: AppTheme.primaryColor,
                                              ),
                                              textColor: AppTheme.primaryColor,
                                              iconColor: AppTheme.blackcolor,
                                              title:  Text(
                                                'Vendor'.tr,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppTheme.primaryColor),
                                              ),
                                              trailing: GestureDetector(
                                                  onTap: () {
                                                    _isValue.value =
                                                        !_isValue.value;
                                                  },
                                                  child: Icon(_isValue.value ==
                                                          true
                                                      ? Icons
                                                          .keyboard_arrow_up_rounded
                                                      : Icons
                                                          .keyboard_arrow_down_outlined)),
                                            ),
                                          ),
                                        ],
                                      )
                                    : _drawerTile(
                            active: true,
                            title: "Vendor".tr,
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_vendor),
                              size: 22,
                              color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.toNamed(ThankYouVendorScreen.thankYouVendorScreen);
                            })
                            : const SizedBox(),
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
                        profileController.isDataLoading.value
                            ? profileController.model.value.data!.isDriver ==
                                    false
                                ? _drawerTile(
                                    active: true,
                                    title: "Sign in as a driver".tr,
                                    icon: const ImageIcon(
                                      AssetImage(AppAssets.drawer_driver),
                                      size: 22,
                                      color: AppTheme.primaryColor,
                                    ),
                                    onTap: () async {
                                      Get.toNamed(DriverRegistrationScreen
                                          .driverRegistrationScreen);
                                    })
                                : profileController
                                            .model.value.data!.asDriverVerified ==
                                        true
                                    ? Column(
                                        children: [
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
                                                AssetImage(
                                                    AppAssets.drawer_driver),
                                                size: 22,
                                                color: AppTheme.primaryColor,
                                              ),
                                              textColor: AppTheme.primaryColor,
                                              iconColor: AppTheme.blackcolor,
                                              title:  Text(
                                                'Driver'.tr,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppTheme.primaryColor),
                                              ),
                                              trailing: GestureDetector(
                                                  onTap: () {
                                                    _isValue1.value =
                                                        !_isValue1.value;
                                                  },
                                                  child: Icon(_isValue1
                                                              .value ==
                                                          true
                                                      ? Icons
                                                          .keyboard_arrow_up_rounded
                                                      : Icons
                                                          .keyboard_arrow_down_outlined)),
                                            ),
                                          ),
                                        ],
                                      )
                                    : _drawerTile(
                                        active: true,
                                        title: "Driver",
                                        icon: const ImageIcon(
                                          AssetImage(AppAssets.drawer_driver),
                                          size: 22,
                                          color: AppTheme.primaryColor,
                                        ),
                                        onTap: () async {
                                          Get.toNamed(
                                              ThankYouVendorScreen.thankYouVendorScreen);
                                        })
                            : const SizedBox(),
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
                            title: "Privacy Policy".tr,
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_privacy),
                              size: 22,
                              color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.toNamed(PrivacyPolicy.privacyPolicyScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Help Center".tr,
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_help),
                              size: 22,
                              color: AppTheme.primaryColor,
                            ),
                            onTap: () async {

                              Get.toNamed(HelpCenter.helpCenterScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Logout".tr,
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_logout),
                              size: 22,
                              color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              _getClientInformation();
                              Get.back();
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              Get.offAllNamed(WelcomeScreen.welcomeScreen);
                            }),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          );
        }),
      ),
    );
  }


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
