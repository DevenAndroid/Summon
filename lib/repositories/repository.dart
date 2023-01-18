// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fresh2_arrive/resources/api_url.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../resources/helper.dart';
// import '../widgets/add_text.dart';
//
// class Repositories{
//   Future<dynamic> postApi({
//     BuildContext? context,
//     required String url,
//     bool? showMap = false,
//     bool? showResponse = true,
//     dynamic mapData,
//   }) async {
//     OverlayEntry loader = Helpers.overlayLoader(context);
//     if(context != null) {
//       Overlay.of(context)!.insert(loader);
//     }
//     ModelLoginResponse model = ModelLoginResponse();
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     if(preferences.getString("user_info") != null) {
//       model = ModelLoginResponse.fromJson(jsonDecode(preferences.getString("user_info")!));
//     }
//     try {
//       final Map<String,String> headers = {
//         HttpHeaders.contentTypeHeader: 'application/json',
//         HttpHeaders.acceptHeader: 'application/json',
//         if(model.authToken != null)
//           HttpHeaders.authorizationHeader:
//           'Bearer ${model.authToken!}'
//       };
//
//       if (kDebugMode) {
//         log("API Url.....  ${ApiUrl.loginApi}");
//         log("API mapData.....  $mapData");
//         if(showMap!) {
//           log("API mapData.....  $headers");
//         }
//       }
//
//       http.Response response = await http.post(Uri.parse(url),
//           body: jsonEncode(mapData), headers: headers);
//
//       if (kDebugMode) {
//         if(showResponse!) {
//           log("API Response........  ${response.body}");
//           log("API Response Status Code........  ${response.statusCode}");
//           log("API Response Reason Phrase........  ${response.reasonPhrase}");
//         }
//       }
//
//       Helpers.hideLoader(loader);
//
//       if(response.statusCode == 200 || response.statusCode == 404) {
//         return response.body;
//       } else if(response.statusCode == 400){
//         showToast(jsonDecode(response.body)["message"]);
//         throw Exception(response.body);
//       } else if(response.statusCode == 401){
//         logOutUser();
//       }
//       else{
//         showToast(response.body);
//         throw Exception(response.body);
//       }
//     } on SocketException catch(e) {
//       Helpers.hideLoader(loader);
//       showToast("No Internet Access");
//       throw Exception(e);
//     }
//   }
//
//
//   Future<dynamic> getApi({
//     BuildContext? context,
//     required String url,
//     bool? showMap = true,
//     bool? showResponse = true,
//     dynamic mapData,
//   }) async {
//     OverlayEntry loader = Helpers.overlayLoader(context);
//     if(context != null) {
//       Overlay.of(context)!.insert(loader);
//     }
//     ModelLoginResponse model = ModelLoginResponse();
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     if(preferences.getString("user_info") != null) {
//       model = ModelLoginResponse.fromJson(
//           jsonDecode(preferences.getString("user_info")!));
//     }
//
//     try {
//       final Map<String,String> headers = {
//         HttpHeaders.contentTypeHeader: 'application/json',
//         HttpHeaders.acceptHeader: 'application/json',
//         if(model.authToken != null)
//           HttpHeaders.authorizationHeader:
//           'Bearer ${model.authToken!}'
//       };
//
//       if (kDebugMode) {
//         if(showMap!) {
//           log("API Url.....  $url");
//           log("API mapData.....  $headers");
//         }
//       }
//
//       http.Response response = await http.get(Uri.parse(url), headers: headers);
//
//       if (kDebugMode) {
//         if(showResponse!) {
//           log("API Response........  ${response.body}");
//           log("API Response Status Code........  ${response.statusCode}");
//           log("API Response Reason Phrase........  ${response.reasonPhrase}");
//         }
//       }
//
//       Helpers.hideLoader(loader);
//
//       if(response.statusCode == 200) {
//         return response.body;
//       } else if(response.statusCode == 400){
//         showToast(jsonDecode(response.body)["message"]);
//         throw Exception(response.body);
//       } else if(response.statusCode == 401){
//         logOutUser();
//       } else {
//         showToast(response.body);
//         throw Exception(response.body);
//       }
//     } on SocketException catch(e) {
//       Helpers.hideLoader(loader);
//       showToast("No Internet Access");
//       throw Exception(e);
//     } catch (e){
//       Helpers.hideLoader(loader);
//       showToast(e.toString());
//       throw Exception(e);
//     }
//   }
//
//   Future<ModelCommonResponse> editUserProfileRepo({
//     required mapData,
//     required fieldName1,
//     required File file1,
//     required context,
//   }) async {
//     OverlayEntry loader = Helpers.overlayLoader(context);
//     Overlay.of(context)!.insert(loader);
//     ModelLoginResponse model = ModelLoginResponse();
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     if(preferences.getString("user_info") != null) {
//       model = ModelLoginResponse.fromJson(
//           jsonDecode(preferences.getString("user_info")!));
//     }
//     try {
//       final Map<String,String> headers = {
//         HttpHeaders.contentTypeHeader: 'application/json',
//         HttpHeaders.acceptHeader: 'application/json',
//         if(model.authToken != null)
//           HttpHeaders.authorizationHeader:
//           'Bearer ${model.authToken!}'
//       };
//       var request =
//       http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileUrl));
//
//       request.headers.addAll(headers);
//
//       request.fields.addAll(mapData);
//
//       if (file1.path != "") {
//         request.files.add(await multipartFile(fieldName1, file1));
//       }
//
//       log(request.fields.toString());
//
//       final response = await request.send();
//       Helpers.hideLoader(loader);
//       if (response.statusCode == 200) {
//         Helpers.hideLoader(loader);
//         return ModelCommonResponse.fromJson(
//             jsonDecode(await response.stream.bytesToString()));
//       } else if(response.statusCode == 401){
//         logOutUser();
//         throw Exception(await response.stream.bytesToString());
//       }
//       else {
//         Helpers.hideLoader(loader);
//         return ModelCommonResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
//       }
//     } on SocketException {
//       Helpers.hideLoader(loader);
//       return ModelCommonResponse(message: "No Internet Access", status: false);
//     } catch (e) {
//       Helpers.hideLoader(loader);
//       return ModelCommonResponse(message: e.toString(), status: false);
//     }
//   }
//
//   Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
//     return http.MultipartFile(
//       fieldName ?? 'file',
//       http.ByteStream(Stream.castFrom(file1.openRead())),
//       await file1.length(),
//       filename: file1.path.split('/').last,
//     );
//   }
//
// }
