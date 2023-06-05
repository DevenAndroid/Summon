import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Social_Login_Model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';


Future<SocialLoginModel> googleLogin(
    provider,
    token,
deviceToken,

    BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var map = <String, dynamic>{};
  map['provider'] = provider;
  map['token'] = token;
  map['device_token'] = deviceToken;
  map['device_id'] = pref.getString('deviceId');

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',

  };



  http.Response response = await http.post(Uri.parse(ApiUrl.socialLogin),
      body: jsonEncode(map), headers: headers);
  log("Social Login api....${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return SocialLoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}