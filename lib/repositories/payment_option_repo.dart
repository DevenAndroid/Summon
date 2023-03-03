import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/delivery_mode_update.dart';
import '../model/payment_option_model.dart';

Future<PaymentOptionModel> paymentOptionRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse(ApiUrl.paymentOptionUrl), headers: headers);
  log("<<<<<<<paymentOption from repository=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<paymentOption from repository=======>${response.body}");
    return PaymentOptionModel.fromJson(json.decode(response.body));
  }
  else {
    throw Exception(response.body);
  }
}
