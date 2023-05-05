import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/SingleProductModel.dart';
import '../model/Social_Login_Model.dart';
import '../resources/api_url.dart';

Future<SingleProductModel> singleProductRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context).insert(loader);
  // try {
  final response =
  await http.get(Uri.parse("${ApiUrl.singleProductUrl}$id"), headers: headers);

  if (response.statusCode == 200|| response.statusCode == 400) {
    //Helpers.hideShimmer(loader);
    //print("${ApiUrl.productUrl}/$id");
    log("Single product details Data...${response.body}");
    return SingleProductModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}
