import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/model_status.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<ModelStatus> selfDeliveryUpdateStatusRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.get(Uri.parse(ApiUrl.selfDeliveryUpdateStatusUrl),
      headers: headers);
  log("self delivery update Status Repository...${response.body}");

  if (response.statusCode == 200) {
    log("self delivery update status Repository...${response.body}");
    return ModelStatus.fromJson(jsonDecode(response.body));
  } else {
    return ModelStatus.fromJson(jsonDecode(response.body));
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}
