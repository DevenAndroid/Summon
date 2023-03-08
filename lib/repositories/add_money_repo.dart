import '../model/add_money_model.dart';
import '../model/model_common_ressponse.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<AddMoneyModel> addMoneyRepo(
    {required amount,required razorpaySignature,required paymentId,required context}) async {
  var map = <String, dynamic>{};
  map['payment_id'] = paymentId;
  map['razorpay_signature'] = razorpaySignature;
  map['amount'] = amount;
  map['response'] = "success";
  log(map.toString());
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
    final response = await http.post(Uri.parse(ApiUrl.addMoneyUrl),
        body: jsonEncode(map), headers: headers);
    Helpers.hideLoader(loader);
    log("money Data...${response.body}");
    if (response.statusCode == 200) {
      Helpers.hideShimmer(loader);
      log("money Data...${response.body}");
      return AddMoneyModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    Helpers.hideLoader(loader);
    throw Exception(e.toString());
  }
}
