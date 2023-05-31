import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Social_Login_Model.dart';
import '../model/model_common_ressponse.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> editAddressREpo({
  map,
  required fieldName1,
  required File file1,
  required context,
}) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  try {
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.editAddressUrl1));
    SharedPreferences pref = await SharedPreferences.getInstance();
    SocialLoginModel? user =
    SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll(map);


    if (file1.path != "") {
      request.files.add(await multipartFile(fieldName1, file1));

    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    String gotResponse = await response.stream.bytesToString();
    print("this iss reponses.${gotResponse}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(
          jsonDecode(gotResponse));

    } else {
      return ModelCommonResponse.fromJson(
          jsonDecode(gotResponse));
    }
  } on SocketException {
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}
