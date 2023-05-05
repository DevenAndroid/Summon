import 'package:get/get.dart';

class RepetItemData {
  RxString itemSize = "".obs;
  RxString price = "".obs;
  RxString minQty = "".obs;
  RxString maxQty = "".obs;
  RxString id = "".obs;


  RepetItemData({
    required this.itemSize,
    required this.price,
    required this.minQty,
    required this.maxQty,
    required this.id,

  });

  RepetItemData.fromJson(Map<String, dynamic> json) {
    itemSize = json['itemSize'];
    price = json['price'];
    minQty = json['minQty'];
    maxQty = json['maxQty'];
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['itemSize'] = itemSize;
    data['price'] = price;
    data['minQty'] = minQty;
    data['maxQty'] = maxQty;
    data['id'] = id;

    return data;
  }
}
