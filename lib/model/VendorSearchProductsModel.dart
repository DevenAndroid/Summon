class VendorSearchProductModel {
  bool? status;
  String? message;
  List<Data>? data;

  VendorSearchProductModel({this.status, this.message, this.data});

  VendorSearchProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? categoryId;
  String? sKU;
  String? name;
  String? qty;
  String? qtyType;
  String? marketPrice;
  String? regularPrice;
  String? content;
  String? image;

  Data(
      {this.id,
      this.categoryId,
      this.sKU,
      this.name,
      this.qty,
      this.qtyType,
      this.marketPrice,
      this.regularPrice,
      this.content,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    sKU = json['SKU'];
    name = json['name'];
    qty = json['qty'];
    qtyType = json['qty_type'];
    marketPrice = json['market_price'];
    regularPrice = json['regular_price'];
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['qty_type'] = this.qtyType;
    data['market_price'] = this.marketPrice;
    data['regular_price'] = this.regularPrice;
    data['content'] = this.content;
    data['image'] = this.image;
    return data;
  }
}
