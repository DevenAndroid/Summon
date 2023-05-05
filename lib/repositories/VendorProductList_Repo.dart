import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Social_Login_Model.dart';
import '../model/VendorProductList_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<VendorProductListModel> vendorProductListRepo({required keyword}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.get(
      Uri.parse("${ApiUrl.vendorProductListUrl}?keyword=$keyword"),
      headers: headers);
  print("Vendor Product List Repository...${response.body}");
  if (response.statusCode == 200) {
    print("Vendor Product List Repository...${response.body}");
    return VendorProductListModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // } catch (e) {
  //   throw Exception(e.toString());
  // }
}
