import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Addons_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<AddonsModel> addOnsRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response =
  await http.get(Uri.parse(ApiUrl.addOnsUrl), headers: headers);

  print("Addons Repository...${response.body}");
  if (response.statusCode == 200) {
    print("Addons Repository...${response.body}");
    return AddonsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  //} catch (e) {
  //throw Exception(e.toString());
}
