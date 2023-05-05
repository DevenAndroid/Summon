import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/HomeSearchModel1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Home_Search_Model.dart';
import '../model/Social_Login_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<HomePageSearchModel1> searchHomeDataPagination(
    {keyword, page, pagination}) async {
  var map = <String, dynamic>{};
  if (keyword != "") {
    map['keyword'] = keyword;
  }
  log(map.toString());
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(Uri.parse("${ApiUrl.searchUrlPagination}?keyword=$keyword&pagination=$pagination&page=$page"),headers: headers);
    log(response.body.toString());
    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
      log("Homepage Search Data with pagination...${response.body}");
      return HomePageSearchModel1.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
