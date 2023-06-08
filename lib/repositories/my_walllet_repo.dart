import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/MyWallet_model..dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

// Future<MyWalletModel> myWalletRepo({required user_type,context}) async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   ModelVerifyOtp? user =
//       ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
//   };
//   try {
//     final response = await http.get(
//         Uri.parse("${ApiUrl.myWalletUrl}?user_type=$user_type"),
//         headers: headers);
//     print("My Wallet Repository...${response.body}");
//     log("${ApiUrl.myWalletUrl}?user_type=$user_type");
//     if (response.statusCode == 200) {
//       print("My Wallet Repository...${response.body}");
//       return MyWalletModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception(response.body);
//     }
//   } catch (e) {
//     throw Exception(e.toString());
//   }
// }


Future<MyWalletModel> myWalletRepo(
    {required page,
      required pagination,
      required user_type,
      search,
      BuildContext? context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  if (context != null) {
    Overlay.of(context).insert(loader);
  }
  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user =
    ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    http.Response response = await http.get(
        Uri.parse("${ApiUrl.myWalletUrl}?user_type=$user_type&page=$page&pagination=$pagination"),
        headers: headers);
    Helpers.hideLoader(loader);
    log("${ApiUrl.myWalletUrl}?user_type=$user_type&page=$page&pagination=$pagination");
    log("Wallet......Response......    ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return MyWalletModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return MyWalletModel(status: true, message: "No Data Found", data: null);
    } else {
      throw Exception(response.body);
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return MyWalletModel(
        status: false, message: "No Internet Access", data: null);
  } catch (e) {
    Helpers.hideLoader(loader);
    throw Exception(e);
  }
}
