import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Social_Login_Model.dart';
import '../model/WishListProduct_Model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';


Future<WishListProductModel> getWishListProductRepo() async {


  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'

  };

  http.Response response = await http.get(Uri.parse(ApiUrl.getWishListUrl),
       headers: headers);

  log("wishlist api....${response.body}");
  if (response.statusCode == 200 || response.statusCode == 400) {
    log("wishlist api....${response.body}");

    return WishListProductModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}