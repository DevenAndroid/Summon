import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import '../model/resend_otp_model.dart';

Future<ResendOtpModel> resendOtp(
    String userPoneNo, BuildContext context) async {
  var map = <String, dynamic>{};
  map['phone'] = userPoneNo;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrl.resendApi),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200 ||response.statusCode == 400) {
    print("<<<<<<<ResendData from repository=======>${response.body}");
    return ResendOtpModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
