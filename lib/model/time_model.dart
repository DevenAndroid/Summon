import 'dart:ui';

import 'package:flutter/material.dart';

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
    value: "Custom calender",
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
