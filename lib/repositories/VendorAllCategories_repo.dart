import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:fresh2_arrive/model/notification_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/VendorAllCategories_Model.dart';
import '../resources/api_url.dart';

Future<VendorAllCategoriesModel> vendorAllCategoryRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(
        Uri.parse(ApiUrl.vendorAllCategoryUrl),
        headers: headers);
    log("vendor All category repo ...${response.body}");
    if (response.statusCode == 200) {
      log("vendor All category repo...${response.body}");
      return VendorAllCategoriesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
