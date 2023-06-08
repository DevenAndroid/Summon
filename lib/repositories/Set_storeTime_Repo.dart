import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/SetStoreTimeModel.dart';
import '../resources/api_url.dart';

Future<SetStoreTimeModel> setStoreTimeRepo() async {
  // Map<String, dynamic> map = {};
  // map['id']=id;
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response =
        await http.get(Uri.parse(ApiUrl.setStoreTimeUrl), headers: headers);
    log("Set Store Time Repository...${response.body}");

    if (response.statusCode == 200) {
      log("Set Store Time Repository...${response.body}");
      return SetStoreTimeModel.fromJson(jsonDecode(response.body));
    } else {
      return SetStoreTimeModel.fromJson(jsonDecode(response.body));
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
