import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/verify_otp_model.dart';

class ApiUrl {
  static const baseUrl = "https://summon.eoxyslive.com/api/";
  static const loginApi = "${baseUrl}login";
  static const socialLogin = "${baseUrl}social-login";
  static const otpApi = "${baseUrl}verify-otp";
  static const wishListUrl = "${baseUrl}add-remove-wishlist";
  static const getWishListUrl = "${baseUrl}list";
  static const privacyPagesUrl = "${baseUrl}pages";
  static const resendApi = "${baseUrl}resend-otp";
  static const categoriesUrl = "${baseUrl}categories";
  static const couponsUrl = "${baseUrl}coupons";
  static const nearStoreLocationUrl = "${baseUrl}near-store";
  static const applyCouponsUrl = "${baseUrl}coupon-apply";
  static const removeCouponsUrl = "${baseUrl}remove-coupon";
  static const orderTipUrl = "${baseUrl}order-tip";
  static const removeTipUrl = "${baseUrl}remove-tip";
  static const userProfileUrl = "${baseUrl}user-profile";
  static const updateProfileUrl = "${baseUrl}update-profile";
  static const homeUrl = "${baseUrl}home";
  static const recommendedDataUrl = "${baseUrl}recommended";
  static const popularHomePageDataUrl = "${baseUrl}popular-products";
  static const homeUrl1 = "${baseUrl}home";
  static const addOnsUrl = "${baseUrl}addons";
  static const varientSizeUrl = "${baseUrl}variants-size";
  static const nearStores = "${baseUrl}stores";
  static const storesUrl = "${baseUrl}near-stores";
  static const myCartUrl = "${baseUrl}my-cart";
  static const orderTypeMyCartUrl = "${baseUrl}order-type";
  static const myCartDataListUrl = "${baseUrl}my-cart";
  static const addCartUrl = "${baseUrl}add-cart";
  static const updateCartUrl = "${baseUrl}update-cart";
  static const removeCartItemUrl = "${baseUrl}remove-cart-item";
  static const addToCartRelatedUrl = "${baseUrl}cart-related-product";
  static const homeSearchUrl = "${baseUrl}search";
  static const storeDetailsUrl = "${baseUrl}store-details";
  static const addAddressUrl = "${baseUrl}add-address";
  static const getSaveAddressUrl = "${baseUrl}get-address";
  static const driverUpdateInfoUrl = "${baseUrl}driver-information-edit";
  static const addAddress1Url = "${baseUrl}add-address";
  static const updateLocationUrl = "${baseUrl}update-location";
  static const myAddressUrl = "${baseUrl}my-address";
  static const myOrdersUrl = "${baseUrl}my-orders";
  static const searchUrlPagination = "${baseUrl}search";
  static const editAddressUrl1 = "${baseUrl}edit-address";
  static const myOrderDetailsUrl = "${baseUrl}order-details";
  static const editAddressUrl = "${baseUrl}edit-address";
  static const removeAddressUrl = "${baseUrl}remove-address";
  static const chooseOrderAddressUrl = "${baseUrl}choose-order-address";
  static const checkOutUrl = "${baseUrl}order";
  static const reOrderUrl = "${baseUrl}re-order/";
  static const checkOutMyCartUrl = "${baseUrl}order";
  static const vendorRegister = "${baseUrl}vendor-register";
  static const vendorInformationEditUrl = "${baseUrl}vendor-information-edit";
  static const myWalletUrl = "${baseUrl}wallet";
  static const paymentOptionUrl = "${baseUrl}payment-option";
  static const vendorOrderListUrl = "${baseUrl}vendor-order-list";
  static const referAndEarnUrl = "${baseUrl}refer-and-earn";
  static const notificationUrl = "${baseUrl}notification-list";
  static const vendorAllCategoryUrl = "${baseUrl}all-categories";
  static const vendorRejectVariantUrl = "${baseUrl}vendor-reject-variant";
  static const withdrawalListUrl = "${baseUrl}withdrawal-list";
  static const withdrawalRequestUrl = "${baseUrl}withdrawal-request";
  static const vendorInformationUrl = "${baseUrl}vendor-information";
  static const storeAvailabilityUrl = "${baseUrl}store-availability";
  static const vendorProductListUrl = "${baseUrl}vendor-product-list";
  static const assignedOrderListUrl = "${baseUrl}assigned-order-list";
  static const vendorSearchProductsUrl = "${baseUrl}products";
  static const vendorAddProductsUrl = "${baseUrl}product";
  static const vendorDashboardUrl = "${baseUrl}vendor-dashboard";
  static const orderAcceptUrl = "${baseUrl}order-accept";
  static const storeUpdateStatusUrl = "${baseUrl}store-status-update";
  static const selfDeliveryUpdateStatusUrl =
      "${baseUrl}self-delivery-status-update";
  static const toggleStatusUrl = "${baseUrl}vendor-product-status-update";
  static const driverDeliveryRequestListUrl =
      "${baseUrl}driver-delivery-request-list";
  static const categoryUrl = "${baseUrl}category";
  static const assignedOrderUrl = "${baseUrl}assigned-order";
  static const driverOrderStatusUpdateUrl =
      "${baseUrl}driver-order-status-update";
  static const driverRegisterUrl = "${baseUrl}driver-register";
  static const driverInformationUrl = "${baseUrl}driver-information";
  static const deliveryVerifyOtpUrl = "${baseUrl}driver-order-status-update";
  static const setStoreTimeUrl = "${baseUrl}store-timing";
  static const updatedSetStoreTimeUrl = "${baseUrl}store-availability";
  static const vendorSaveProductUrl = "${baseUrl}vendor-add-product";
  static const resendDeliveryOtpUrl = "${baseUrl}resend-delivery-otp";
  static const driverDeliveryModeUpdateUrl =
      "${baseUrl}driver-delivery-mode-update";
  static const addMoneyUrl = "${baseUrl}add-money";
  static const singleProductUrl = "${baseUrl}product/";
  static const onlineSuccessPaymentUrl = "${baseUrl}online-success-payment";
  static const vendorEditProductUrl = "${baseUrl}product/";
  static const vendorBankDetailsUrl = "${baseUrl}account-details";
  static const vendorBankListUrl = "${baseUrl}banks-list";
  static const vendorAddBankDetailsUrl = "${baseUrl}add-account-details";
  static const helpCenterUrl = "${baseUrl}faq-list";
  static const singleCategoryUrl = "${baseUrl}single-category";
  static const signupUrl = "${baseUrl}register";
  static const loginUrl = "${baseUrl}login";
  static const VendorCategoryUrl = "${baseUrl}all-store-categories";

}

getHeaders() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    if (pref.getString('user_info') != null)
      HttpHeaders.authorizationHeader:
          'Bearer ${ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!)).authToken}'
  };
  return headers;
}
Future<String> getUserToken() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  ModelVerifyOtp model = ModelVerifyOtp.fromJson(
      jsonDecode(sharedPreference.getString("userData")!));
  return model.data!.profileImage.toString();
}
