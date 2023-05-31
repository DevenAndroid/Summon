import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/MyOrderDetails_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<MyOrdersDetailsModel> myOrderDetailsRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  print("${ApiUrl.myOrderDetailsUrl}?order_id=$id");
    final response = await http.get(
        Uri.parse("${ApiUrl.myOrderDetailsUrl}?order_id=$id"),
        headers: headers);
    log("MyOrder Details...${response.body}");
    if (response.statusCode == 200) {
      log("MyOrder Details...${response.body}");
      return MyOrdersDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  // } catch (e) {
  // }
}
