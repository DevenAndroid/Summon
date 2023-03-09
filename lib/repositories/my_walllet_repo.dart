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

Future<MyWallletModel> myWalletRepo({required user_type,context}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  try {
    final response = await http.get(
        Uri.parse("${ApiUrl.myWalletUrl}?user_type=$user_type"),
        headers: headers);
    print("My Wallet Repository...${response.body}");
    log("${ApiUrl.myWalletUrl}?user_type=$user_type");
    if (response.statusCode == 200) {
      print("My Wallet Repository...${response.body}");
      return MyWallletModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
