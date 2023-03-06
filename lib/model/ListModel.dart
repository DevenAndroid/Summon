class ListModel {
  String? qty;
  String? price;
  String? minQty;
  String? maxQty;

  ListModel({this.qty, this.price, this.minQty, this.maxQty});

  ListModel.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    price = json['price'];
    minQty = json['minQty'];
    maxQty = json['maxQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['qty'] = qty;
    data['price'] = price;
    data['minQty'] = minQty;
    data['maxQty'] = maxQty;
    return data;
  }
}
