import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Withdrawal_Request_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<WithdrawalRequestModel> withdrawalRequestRepo(amount, context) async {
  var map = <String, dynamic>{};
  map['amount'] = amount;
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
    final response = await http.post(Uri.parse(ApiUrl.withdrawalRequestUrl),
        body: jsonEncode(map), headers: headers);
    log("withdrawal Request Repo...${response.body}");
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      log("withdrawal Request Repo...${response.body}");
      return WithdrawalRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
