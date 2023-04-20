import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/app_assets.dart';
import 'package:client_information/client_information.dart';
import 'package:flutter/services.dart';

import 'Onboarding_Screen_page.dart';
import 'custum_bottom_bar.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      _getClientInformation();
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString('user_info') != null) {
        Get.toNamed(CustomNavigationBar.customNavigationBar);
      }

      Get.offAllNamed(OnBoardingScreenPage.onBoarding);

    });
  }

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      log('Failed to get client information');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', info!.deviceId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFE724C),
      body: Stack(
        children: [

          Positioned(
              top: 310,
              right: 24,
              left: 24,
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.splash0,
                    width: 160,
                    height: 207,
                    fit: BoxFit.cover,
                  ),

                ],
              )),
        ],
      ),
    );
  }
}
