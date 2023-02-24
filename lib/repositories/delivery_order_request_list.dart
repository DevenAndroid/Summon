import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/driver_delivery_order_list.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/My_Cart_Model.dart';
import '../model/verify_otp_model.dart';

Future<DriverDeliveryOrderList> driverDeliveryOrderListRepo() async {
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
    await http.get(Uri.parse(ApiUrl.driverDeliveryRequestListUrl), headers: headers);

    if (response.statusCode == 200) {
      log("Driver Delivery Request List Data...${response.body}");
      return DriverDeliveryOrderList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}