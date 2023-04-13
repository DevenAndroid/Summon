import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> addAddress(
    {required location,
    required flat_no,
    required street,
    required landmark,
    required address_type,
    required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['location'] = location;
  map['flat_no'] = flat_no;
  map['street'] = street;
  map['landmark'] = landmark;
  map['address_type'] = address_type;
  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.addAddressUrl),
      body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200 ||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ModelCommonResponse> editAddress(
    {required location,
    required flat_no,
    required street,
    required landmark,
    required address_type,
    required address_id,
    required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['location'] = location;
  map['flat_no'] = flat_no;
  map['street'] = street;
  map['landmark'] = landmark;
  map['address_type'] = address_type;
  map['address_id'] = address_id;
  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.editAddressUrl),
      body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ModelCommonResponse> removeAddress(
    {required addressId, required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['address_id'] = addressId;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.removeAddressUrl),
      headers: headers, body: jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ModelCommonResponse> vendorRejectVariantRepo({
  required order_variant_id,
}) async {
  var map = <String, dynamic>{};
  map['order_variant_id'] = order_variant_id;
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  //?order_variant_id=$order_variant_id
  http.Response response = await http.post(
      Uri.parse(ApiUrl.vendorRejectVariantUrl),
      headers: headers,
      body: jsonEncode(map));
  log("Vendor Reject Repository...${response.body.toString()}");
  if (response.statusCode == 200) {
    // Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    // Helpers.createSnackBar(context, response.body.toString());
    // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
