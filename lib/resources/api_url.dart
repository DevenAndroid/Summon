import 'package:flutter/material.dart';

class ApiUrl {
  static const baseUrl = "https://fresh2arrive.eoxyslive.com/api/";
  static const loginApi = "${baseUrl}login";
  static const otpApi = "${baseUrl}verify-otp";
  static const resendApi = "${baseUrl}resend-otp";
  static const categoriesUrl = "${baseUrl}categories";
  static const couponsUrl = "${baseUrl}coupons";
  static const userProfileUrl = "${baseUrl}user-profile";
  static const updateProfileUrl = "${baseUrl}update-profile";
  static const myCartUrl = "${baseUrl}my-cart";
  static const addCartUrl = "${baseUrl}add-cart";
  //static const stores = "${baseUrl}near-stores";
}
