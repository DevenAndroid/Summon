import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Remove_CartItem_model.dart';
import '../model/model_common_ressponse.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> removeCartItemRepo(
    String cart_item_id, context) async {
  var map = <String, dynamic>{};
  map['cart_item_id'] = cart_item_id;
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
    print(map);
    final response = await http.post(Uri.parse(ApiUrl.removeCartItemUrl),
        body: jsonEncode(map), headers: headers);
    Helpers.hideLoader(loader);
    print("Remove Cart Data...${response.body}");
    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      print("Remove Cart Data...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    Helpers.hideLoader(loader);
    throw Exception(e.toString());
  }
}
