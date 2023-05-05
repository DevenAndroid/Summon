import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Social_Login_Model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';


Future<ModelCommonResponse> wishListRepo(
    {required productId,
      required BuildContext context}) async {



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

  http.Response response = await http.post(Uri.parse(ApiUrl.wishListUrl),
      body: jsonEncode(productId), headers: headers);
  //response.headers.addAll(headers);

  log("wishlist api....${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    log("wishlist api....${response.body}");
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}