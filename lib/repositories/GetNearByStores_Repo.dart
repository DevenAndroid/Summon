import 'dart:convert';
import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/GetNearByStores_Model.dart';


Future<GetNearByStoreModel> getNearByStores() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response =
  await http.get(Uri.parse(ApiUrl.nearStoreLocationUrl), headers: headers);

  if (response.statusCode == 200) {
    print("Near by Stores Location${response.body}");
    return GetNearByStoreModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
