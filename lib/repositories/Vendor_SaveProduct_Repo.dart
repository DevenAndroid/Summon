// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../model/VendorSaveProduct_Model.dart';
// import '../model/verify_otp_model.dart';
// import '../resources/api_url.dart';
//
// //
// Future<VendorSaveProductModel> updatedSetStoreTimeRepo(
//     List<VendorSaveProductModel> data) async {
//   Map<String, dynamic> map = {};
// List<Product> map = Product(maxQty: "");
//   map["product_id"] = product_id;
//   map["category_id"] = category_id;
//   map["variants"[0]] = map;
//
//   //log('start_time :${jsonEncode(map).toString()}');
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   ModelVerifyOtp? user =
//       ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
//   };
//
//   try {
//     final response = await http.post(Uri.parse(ApiUrl.vendorSaveProductUrl),
//         headers: headers);
//     log("Vendor Save product Repository...${response.body}");
//
//     if (response.statusCode == 200) {
//       log("Vendor Save product Repository...${response.body}");
//       return VendorSaveProductModel.fromJson(jsonDecode(response.body));
//     } else {
//       return VendorSaveProductModel.fromJson(jsonDecode(response.body));
//     }
//   } catch (e) {
//     throw Exception(e.toString());
//   }
// }
