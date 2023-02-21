import 'package:flutter/material.dart';

class ApiUrl {
  static const baseUrl = "https://fresh2arrive.eoxyslive.com/api/";
  static const loginApi = "${baseUrl}login";
  static const otpApi = "${baseUrl}verify-otp";
  static const resendApi = "${baseUrl}resend-otp";
  static const categoriesUrl = "${baseUrl}categories";
  static const couponsUrl = "${baseUrl}coupons";
  static const applyCouponsUrl = "${baseUrl}coupon-apply";
  static const removeCouponsUrl = "${baseUrl}remove-coupon";
  static const orderTipUrl = "${baseUrl}order-tip";
  static const removeTipUrl = "${baseUrl}remove-tip";
  static const userProfileUrl = "${baseUrl}user-profile";
  static const updateProfileUrl = "${baseUrl}update-profile";
  static const storeUrl = "${baseUrl}store";
  static const homeUrl = "${baseUrl}home";
  static const nearStores = "${baseUrl}stores";
  static const myCartUrl = "${baseUrl}my-cart";
  static const addCartUrl = "${baseUrl}add-cart";
  static const updateCartUrl = "${baseUrl}update-cart";
  static const removeCartItemUrl = "${baseUrl}remove-cart-item";
  static const addToCartRelatedUrl = "${baseUrl}cart-related-product";
  static const homeSearchUrl = "${baseUrl}search";
  static const storeDetailsUrl = "${baseUrl}store-details";
  static const addAddressUrl = "${baseUrl}add-address";
  static const updateLocationUrl = "${baseUrl}update-location";
  static const myAddressUrl = "${baseUrl}my-address";
  static const editAddressUrl = "${baseUrl}edit-address";
  static const removeAddressUrl = "${baseUrl}remove-address";
  static const chooseOrderAddressUrl = "${baseUrl}choose-order-address";
  static const checkOutUrl = "${baseUrl}order";
}
