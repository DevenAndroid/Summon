import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  RxInt currentIndex = 2.obs;
  RxBool internetConnection = true.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  onItemTap(int value) {
    currentIndex.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    print("result11111");
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("result11111");
      if (result == ConnectivityResult.none) {
        internetConnection.value = false;
      } else {
        internetConnection.value = true;
      }
    });
  }
}
