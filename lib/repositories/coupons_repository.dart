import 'dart:convert';
import 'dart:io';
import 'package:fresh2_arrive/model/coupon_mpdel.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/verify_otp_model.dart';

Future<CouponModel> couponData(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response =
      await http.get(Uri.parse(ApiUrl.couponsUrl), headers: headers);

  if (response.statusCode == 200) {
    print("<<<<<<<CouponData from repository=======>${response.body}");
    return CouponModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
