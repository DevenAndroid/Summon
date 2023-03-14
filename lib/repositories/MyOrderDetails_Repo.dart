import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/MyOrderDetails_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<MyOrdersDetailsModel> myOrderDetailsRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
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
