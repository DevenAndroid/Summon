import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Store_Details_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<StoreDetailsModel> storeDetailsRepo(id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context).insert(loader);
  print("${ApiUrl.storeDetailsUrl}/$id");
  try {
    final response =
        await http.get(Uri.parse("${ApiUrl.storeDetailsUrl}/$id"), headers: headers);

    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
      print("${ApiUrl.storeDetailsUrl}/$id");
      print("Store details Data...${response.body}");
      return StoreDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}




Future<StoreDetailsModel> storeDetailsRepo1(
    {required page,
      required pagination,
      required id,
      search,
      BuildContext? context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  if (context != null) {
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
    log("${ApiUrl.storeDetailsUrl}/$id?page=$page&pagination=$pagination&keyword=$search");
    http.Response response = await http.get(
        Uri.parse("${ApiUrl.storeDetailsUrl}/$id?page=$page&pagination=$pagination&keyword=$search"),
        headers: headers);
    Helpers.hideLoader(loader);
    log("${ApiUrl.storeDetailsUrl}/$id?page=$page&pagination=$pagination&keyword=$search");
    log("Single store List APi......Response......    ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return StoreDetailsModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return StoreDetailsModel(status: true, message: "No Data Found", data: null);
    } else {
      throw Exception(response.body);
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return StoreDetailsModel(
        status: false, message: "No Internet Access", data: null);
  } catch (e) {
    Helpers.hideLoader(loader);
    throw Exception(e);
  }
}