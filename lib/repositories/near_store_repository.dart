import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:fresh2_arrive/resources/helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<NearStoreModel> loadWithPagination({
   page,
  pagination,
  BuildContext? context
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  if(context != null){

    Overlay.of(context)!.insert(loader);
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
        Uri.parse("${ApiUrl.nearStores}?page=$page&pagination=$pagination"),
        headers: headers);
    Helpers.hideLoader(loader);
    log("${ApiUrl.nearStores}?page=$page&pagination=2");
    log("NearStore List APi......    ${ApiUrl.nearStores}");
    log("NearStore List APi......Response......    ${response.body}");
    if (response.statusCode == 200) {
      return NearStoreModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return NearStoreModel(status: true, message: "No Data Found", data: null);
    } else {
      throw Exception(response.body);
    }
  } on SocketException {

    Helpers.hideLoader(loader);
    return NearStoreModel(
        status: false, message: "No Internet Access", data: null);
  } catch (e) {
    Helpers.hideLoader(loader);
    throw Exception(e);
  }
}
