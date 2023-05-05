import 'package:get/get.dart';

class ListModel1 {
  RxString name = "".obs;
  RxString price = "".obs;
  RxString addonType = "".obs;
  RxString addonTypeId = "".obs;

  ListModel1({
    required this.name,
    required this.price,
    required this.addonType,
    required this.addonTypeId,
  });

  ListModel1.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    addonType = json['addOn'];
    addonTypeId = json['addOnId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['price'] = price;
    data['addOn'] = addonType;
    data['addOnId'] = addonTypeId;

    return data;
  }
}
