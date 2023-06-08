import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/CheckOut_Model1.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<CheckOutModel1> checkOutRepo1(
    {type,payment_type,required context}) async {
  var map = <String, dynamic>{};
  map['type'] = type;
  map['payment_type'] = payment_type;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(map.toString());
  http.Response response = await http.post(Uri.parse(ApiUrl.checkOutMyCartUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200 || response.statusCode==400) {
    Helpers.hideLoader(loader);
    return CheckOutModel1.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

