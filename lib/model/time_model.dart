import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';

class TimeModel {
  dynamic key;
  dynamic value;
  TimeModel({this.key, this.value});
}

List<TimeModel> timeData = [
  TimeModel(
    key: "this_week",
    value: "This Week",
  ),
  TimeModel(
    key: "last_week",
    value: "Last Week",
  ),
  TimeModel(
    key: "this_month",
    value: "This Month",
  ),
  TimeModel(
    key: "last_three_month",
    value: "Last three Month",
  ),
  TimeModel(
    key: "custom",
    value: "Custom",
  ),
];

class Status {
  dynamic key;
  dynamic value;
  Status({this.key, this.value});
}

List<Status> status = [
  Status(
    key: "OP",
    value: "Order Placed",
  ),
  Status(
    key: "A",
    value: "Accepted",
  ),
  Status(
    key: "P",
    value: "Pending",
  ),
  Status(
    key: "R",
    value: "Reject",
  ),
  Status(
    key: "PC",
    value: "Pickup",
  ),
  Status(
    key: "RR",
    value: "Return Request",
  ),
  Status(
    key: "RF",
    value: "Refund",
  ),
  Status(
    key: "D",
    value: "Delivered",
  ),
];

class Status1 {
  dynamic key;
  dynamic value;
  Status1({this.key, this.value});
}

List<Status1> status1 = [
  Status1(
    key: "PC",
    value: "Pickup",
  ),
  Status1(
    key: "D",
    value: "Delivered",
  ),
  Status1(
    key: "R",
    value: "Rejected",
  ),
];

class WalletModel {
  dynamic key;
  dynamic value;
  dynamic image;
  Color color;
  WalletModel({this.key, this.value, this.image, required this.color});
}

List<WalletModel> walletModel = [
  WalletModel(
      key: "A",
      value: "All",
      image: AppAssets.allIcon,
      color: AppTheme.appPrimaryPinkColor),
  WalletModel(
      key: "V",
      value: "Vendor",
      image: AppAssets.store,
      color: AppTheme.appPrimaryGreenColor),
  WalletModel(
      key: "D",
      value: "Driver",
      image: AppAssets.driverIcon,
      color: AppTheme.appPrimaryYellowColor),
  WalletModel(
      key: "C",
      value: "Customer",
      image: AppAssets.personIcon,
      color: AppTheme.appPrimaryOrangeColor),
];

class SelectQtyType {
  dynamic key;
  dynamic value;
  SelectQtyType({this.key, this.value});
}

List<SelectQtyType> qtyType = [
  SelectQtyType(
    key: "kg",
    value: "kg",
  ),
  SelectQtyType(
    key: "grm",
    value: "grm",
  ),
  SelectQtyType(
    key: "ltr",
    value: "ltr",
  ),
  SelectQtyType(
    key: "ml",
    value: "ml",
  ),
  SelectQtyType(
    key: "dozen",
    value: "dozen",
  ),
  SelectQtyType(
    key: "pieces",
    value: "pieces",
  ),
];

class Area {
  dynamic key;
  dynamic value;
  Area({this.key, this.value});
}

List<Area> area = [
  Area(
    key: "500",
    value: "500 Meter",
  ),
  Area(
    key: "1",
    value: "1 km",
  ),
  Area(
    key: "2",
    value: "2 km",
  ),
  Area(
    key: "3",
    value: "3 km",
  ),
  Area(
    key: "4",
    value: "4 km",
  ),
  Area(
    key: "5",
    value: "5 km",
  ),
  Area(
    key: "6",
    value: "6 km",
  ),
  Area(
    key: "7",
    value: "7 km",
  ),
  Area(
    key: "8",
    value: "8 km",
  ),
  Area(
    key: "9",
    value: "9 km",
  ),
  Area(
    key: "10",
    value: "10 km",
  ),
  Area(
    key: "15",
    value: "15 km",
  ),
  Area(
    key: "20",
    value: "20 km",
  ),
  Area(
    key: "25",
    value: "25 km",
  ),
  Area(
    key: "30",
    value: "30 km",
  ),
  Area(
    key: "35",
    value: "35 km",
  ),
  Area(
    key: "40",
    value: "40 km",
  ),
  Area(
    key: "45",
    value: "45 km",
  ),
  Area(
    key: "50",
    value: "50 km",
  ),
];
