import 'dart:io';
import 'package:fresh2_arrive/model/Social_Login_Model.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/MyCartDataListModel.dart';
import '../model/My_Cart_Model.dart';
import '../model/verify_otp_model.dart';

Future<MyCartData> myCartRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // try {
    final response =
        await http.get(Uri.parse(ApiUrl.myCartUrl), headers: headers);

    if (response.statusCode == 200) {
      print("My Cart Data...${response.body}");
      return MyCartData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}


// MyCart data

Future<MyCartDataModel1> myCartDataRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // try {
  final response =
  await http.get(Uri.parse(ApiUrl.myCartDataListUrl), headers: headers);

  if (response.statusCode == 200) {
    print("My Cart Data List...${response.body}");
    return MyCartDataModel1.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}
// Order type api
Future<ModelCommonResponse> orderTypeRepo({required orderType}) async {
  var map = <String, dynamic>{};
  map['order_type']=orderType;
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // try {
  final response =
  await http.post(Uri.parse(ApiUrl.orderTypeMyCartUrl), headers: headers,body: jsonEncode(map));

  if (response.statusCode == 200) {
    print("order type repo...${response.body}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}
