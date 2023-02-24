import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/assigned_order_list.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/verify_otp_model.dart';

Future<AssignedOrderList> assignedOrderListRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  try {
    final response =
    await http.get(Uri.parse(ApiUrl.assignedOrderListUrl), headers: headers);

    if (response.statusCode == 200) {
      log("AssignedOrder List Data...${response.body}");
      return AssignedOrderList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}