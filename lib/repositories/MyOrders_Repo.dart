import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/MyOrder_Model.dart';
import '../model/model_common_ressponse.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<MyOrdersModel> myOrderRepo({required filter, required status,required start_date, required end_date}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

   // try {
  final response = await http.get(
      Uri.parse("${ApiUrl.myOrdersUrl}?filter=$filter&status=$status&start_date=$start_date&end_date=$end_date"),
      headers: headers);
  print("My Orders Repository...${response.body}");
  print("${ApiUrl.myOrdersUrl}?filter=$filter&status=$status&start_date=$start_date&end_date=$end_date");
  if (response.statusCode == 200) {
    print("My Orders Repository...${response.body}");
    return MyOrdersModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // }
  // catch (e) {
  //  throw Exception(e.toString());
  // }
}

// Reorder repo
Future<ModelCommonResponse> reOrderRepo(
    {required context,required id}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
 // log(map.toString());
  http.Response response = await http.post(Uri.parse("${ApiUrl.reOrderUrl}$id"),headers: headers,);
  log(response.body.toString());
  if (response.statusCode == 200 || response.statusCode==400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

