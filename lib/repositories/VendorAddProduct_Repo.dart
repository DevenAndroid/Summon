import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/VendorAddProduct_Model.dart';
import '../resources/api_url.dart';

Future<VendorAddProductModel> vendorAddProductRepo({
  required id,
}) async {
  final response = await http
      .get(Uri.parse("${ApiUrl.vendorAddProductsUrl}/$id"), headers: await getHeaders());

  print("Vendor add product Repository...${response.body}");
  if (response.statusCode == 200) {
    //Helpers.hideLoader(loader);
    print("Vendor add product  Repository...${response.body}");
    return VendorAddProductModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // } catch (e) {
  //   throw Exception(e.toString());
  // }
}
