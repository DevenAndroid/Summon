import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:fresh2_arrive/model/home_page_model.dart';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ViewAllRecommended_Model.dart';

Future<ViewAllRecommendedModel> viewAllRecommendedData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse(ApiUrl.recommendedDataUrl), headers: headers);
  log(" view all recommended HomePageData >${response.body}");
  if (response.statusCode == 200) {
    log(" view all recommended HomePageData ${response.body}");
    return ViewAllRecommendedModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
