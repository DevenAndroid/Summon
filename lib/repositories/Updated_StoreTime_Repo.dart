import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/SetStoreTimeModel.dart';
import '../model/Updated_StoreTime_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<UpdatedStoreTimeModel> updatedSetStoreTimeRepo(
    List<StoreTimeData> data, BuildContext context) async {
  Map<String, dynamic> map = {};
  Map<String, dynamic> map1 = {};
  Map<String, dynamic> map2 = {};
  Map<String, dynamic> map3 = {};

  String getFormatedString(String value){

    DateTime? time;
    try {
      time = DateFormat("hh:mm a").parse(value);
    } catch(e){
      time = DateFormat("hh:mm").parse(value);
    }
    return
      // DateFormat("hh:mm a").format(time);
       "${TimeOfDay.fromDateTime(time).hour}:${TimeOfDay.fromDateTime(time).minute}";
  }

  for (var i = 0; i < data.length; i++) {

    map1['$i'] = getFormatedString(data[i].startTime.toString());
    map2['$i'] = getFormatedString(data[i].endTime.toString());
    map3['$i'] = data[i].status! ? 1 : 0;
  }
  map["start_time"] = map1;
  map["end_time"] = map2;
  map["status"] = map3;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  log('start_time :${jsonEncode(map).toString()}');
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.post(Uri.parse(ApiUrl.updatedSetStoreTimeUrl),
        body: jsonEncode(map), headers: headers);
    log("Updated Set Store Time Repository...${response.body}");

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      log("Updated Set Store Time Repository...${response.body}");
      return UpdatedStoreTimeModel.fromJson(jsonDecode(response.body));
    } else {
      return UpdatedStoreTimeModel.fromJson(jsonDecode(response.body));
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
