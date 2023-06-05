import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/HomeSearchModel1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Home_Search_Model.dart';
import '../model/Social_Login_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<HomePageSearchModel1> searchHomeDataPagination(
    {required BuildContext? context, required keyword, required page, required pagination, }) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  if(context != null){
    Overlay.of(context).insert(loader);
  }

  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(Uri.parse("${ApiUrl.searchUrlPagination}?keyword=$keyword&pagination=10&page=$page"),headers: headers);
    log(response.body.toString());
    // Helpers.hideLoader(loader);
    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
       Helpers.hideLoader(loader);
      log("Homepage Search Data with pagination...${response.body}");
      return HomePageSearchModel1.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    Helpers.hideLoader(loader);
    throw Exception(e.toString());
  }
}
