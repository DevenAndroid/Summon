import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Add_To_Cart_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<AddToCartData> addToCartRepo(
    variant_id, product_id, qty, context) async {
  var map = <String, dynamic>{};
  map['variant_id'] = variant_id;
  map['product_id'] = product_id;
  map['qty'] = qty;
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  log(map.toString());
  try {
    final response = await http.post(Uri.parse(ApiUrl.addCartUrl),
        body: jsonEncode(map), headers: headers);
    log("Add To Cart Data...${response.body}");
    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      log("Add To Cart Data...${response.body}");
      return AddToCartData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}


Future<ModelCommonResponse> addToCartRepo1(
    {variant_id, product_id, qty, addons_Id, note, itemPrice, context}) async {
  var map = <String, dynamic>{};
  if(variant_id != ""){
    map['variant_id'] = variant_id;
  }

  map['product_id'] = product_id;
  map['qty'] = qty;
  map['addons'] = addons_Id;
  map['note'] = note;
  map['item_price'] = itemPrice;
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  log(map.toString());
  try {
    final response = await http.post(Uri.parse(ApiUrl.addCartUrl),
        body: jsonEncode(map), headers: headers);
    log("Add To Cart Data...${response.body}");
    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      log("Add To Cart Data...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}







Future<ModelCommonResponse> updateCartRepo(cartItemId, qty, context) async {
  var map = <String, dynamic>{};
  map['cart_item_id'] = cartItemId;
  map['qty'] = qty;
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    final response = await http.post(Uri.parse(ApiUrl.updateCartUrl),
        body: jsonEncode(map), headers: headers);
    print("Update Cart Data...${response.body}");
    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      print("Update Cart Data...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
