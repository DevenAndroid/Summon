import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Social_Login_Model.dart';
import '../model/delivery_mode_update.dart';
import '../model/driver_information_model.dart';
import '../model/model_common_ressponse.dart';
import '../resources/helper.dart';
import 'Add_Address1_repo.dart';

Future<DriverInformationModel> driverInformationRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse(ApiUrl.driverInformationUrl), headers: headers);
  log("<<<<<<<DriverInformation from repository=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<DriverInformation from repository=======>${response.body}");
    return DriverInformationModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

// Driver information Update
Future<ModelCommonResponse> driverUpdateInformationRepo({
  mapData,
  required fieldName1,
  required fieldName2,
  required fieldName3,
  required File file1,
  required File file2,
  required File file3,
  required context,
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  try {
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.driverUpdateInfoUrl));
    SharedPreferences pref = await SharedPreferences.getInstance();
    SocialLoginModel? user =
    SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll(mapData);

    if (file1.path != "") {
      request.files.add(await multipartFile(fieldName1, file1));

    }
    if (file2.path != "") {
      request.files.add(await multipartFile(fieldName2, file2));

    }
    if (file3.path != "") {
      request.files.add(await multipartFile(fieldName3, file3));

    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    // log("Driver Update information api..${response}");
    // log("this iss reponses.${await response.stream.bytesToString()}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      return ModelCommonResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    }
  } on SocketException {
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}
