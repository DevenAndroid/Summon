import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:fresh2_arrive/model/VendorAddProduct_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../resources/api_url.dart';

Future<VendorAddProductModel> vendorEditProductRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  print("URLLLLL.. ${ApiUrl.vendorEditProductUrl}$id");
   try {
  final response = await http
      .get(Uri.parse("${ApiUrl.vendorEditProductUrl}$id"), headers: headers);
  print("Vendor Edit Product repo Repository...${response.body}");

  if (response.statusCode == 200 ||response.statusCode == 400) {
    print("Vendor Edit Product repo Repository...${response.body}");
    return VendorAddProductModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  } catch (e) {
    throw Exception(e.toString());
  }
}
