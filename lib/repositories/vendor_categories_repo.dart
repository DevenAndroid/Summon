


import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/vendor_category_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<CategoriesModel> vendorCategoryRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response =
    await http.get(Uri.parse(ApiUrl.VendorCategoryUrl), headers: headers);
   // print("Category Repository...${response.body}");
    if (response.statusCode == 200) {
      print("Category Repository...${response.body}");
      return CategoriesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}