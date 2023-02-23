import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/MyOrder_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<MyOrdersModel> myOrderRepo({required filter, required status,required start_date, required end_date}) async {
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
      Uri.parse("${ApiUrl.myOrdersUrl}?filter=$filter&status=$status&start_date=$start_date&end_date=$end_date"),
      headers: headers);
  print("My Orders Repository...${response.body}");
  print("${ApiUrl.myOrdersUrl}?filter=$filter&status=$status&start_date=$start_date&end_date=$end_date");
  if (response.statusCode == 200) {
    print("My Orders Repository...${response.body}");
    return MyOrdersModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // }
  // catch (e) {
  //  throw Exception(e.toString());
  // }
}
