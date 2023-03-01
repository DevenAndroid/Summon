import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/model_common_ressponse.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<ModelCommonResponse> orderAcceptRepo(String order_id) async {
  var map = <String, dynamic>{};

  map['order_id'] = order_id;
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.post(Uri.parse(ApiUrl.orderAcceptUrl),
      body: jsonEncode(map), headers: headers);
  log("Order Accept Repository...${response.body}");

  if (response.statusCode == 200) {
    log("Order Accept Repository...${response.body}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  } else {
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}
