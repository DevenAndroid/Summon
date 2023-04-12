import 'package:get/get.dart';

class ListModel {
  RxString qty = "".obs;
  RxString qtyType = "".obs;
  RxString price = "".obs;
  RxString minQty = "".obs;
  RxString maxQty = "".obs;
  RxString varientId = "".obs;
  RxString? marketPrice = "".obs;

  ListModel({
    required this.qty,
    required this.price,
    required this.minQty,
    required this.varientId,
    required this.maxQty,
    required this.qtyType,
    required this.marketPrice,
  });

  ListModel.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    price = json['price'];
    minQty = json['minQty'];
    maxQty = json['maxQty'];
    marketPrice = json['marketPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['qty'] = qty;
    data['price'] = price;
    data['minQty'] = minQty;
    data['maxQty'] = maxQty;
    data['marketPrice'] = marketPrice;
    return data;
  }
}
