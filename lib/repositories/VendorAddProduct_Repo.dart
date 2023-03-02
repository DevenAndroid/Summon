import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/VendorAddProduct_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<VendorAddProductModel> vendorAddProductRepo({
  required id,
}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context as BuildContext).insert(loader);
  //try {
  final response = await http
      .get(Uri.parse("${ApiUrl.vendorAddProductsUrl}/$id"), headers: headers);
  print("Vendor add product Repository...${response.body}");
  if (response.statusCode == 200) {
    //Helpers.hideLoader(loader);
    print("Vendor add product  Repository...${response.body}");
    return VendorAddProductModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // } catch (e) {
  //   throw Exception(e.toString());
  // }
}
