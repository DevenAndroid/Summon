import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/HelpCenterModel.dart';
import '../model/PrivacyModel.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<HelpCenterModel> helpCenterRepo({required keyword}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.get(
      Uri.parse("${ApiUrl.helpCenterUrl}?keyword=$keyword"),
      headers: headers);
  //log("Help Center Repository...${response.body}");
  if (response.statusCode == 200) {
    log("Help Center Repository...${response.body}");
    return HelpCenterModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // } catch (e) {
  // }
}

Future<PrivacyModel> privacyPolicy() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http
      .get(Uri.parse("${ApiUrl.privacyPagesUrl}?slug=privacy-policy"), headers: headers);
  if (response.statusCode == 200) {
    log("<<<<<<<privacy-policy from repository=======>${response.body}");
    return PrivacyModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
