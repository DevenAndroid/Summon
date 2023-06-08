import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/check_out_model.dart';
import '../model/payment_option_model.dart';
import '../resources/helper.dart';

Future<CheckOutDataModel> paymentOrder(
    {required order_id,
    required payment_id,
    required razorpay_signature,
    required wallet_deduction,
    required online_deduction,
    required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['order_id'] = order_id;
  map['payment_id'] = payment_id;
  map['razorpay_signature'] = razorpay_signature;
  map['wallet_deduction'] = wallet_deduction;
  map['online_deduction'] = online_deduction;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(map.toString());
  http.Response response = await http.post(
      Uri.parse(ApiUrl.onlineSuccessPaymentUrl),
      headers: headers,
      body: jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200 || response.statusCode==400) {
    Helpers.hideLoader(loader);
    return CheckOutDataModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, "Something went worng");
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
