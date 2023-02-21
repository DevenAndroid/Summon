class AddToCartData {
  bool? status;
  String? message;
  List<Data>? data;

  AddToCartData({this.status, this.message, this.data});

  AddToCartData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? variantQty;
  String? variantQtyType;
  int? variantPrice;
  int? cartItemQty;
  int? totalPrice;
  String? image;

  Data(
      {this.id,
      this.name,
      this.variantQty,
      this.variantQtyType,
      this.variantPrice,
      this.cartItemQty,
      this.totalPrice,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    variantQty = json['variant_qty'];
    variantQtyType = json['variant_qty_type'];
    variantPrice = json['variant_price'];
    cartItemQty = json['cart_item_qty'];
    totalPrice = json['total_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['variant_qty'] = variantQty;
    data['variant_qty_type'] = variantQtyType;
    data['variant_price'] = variantPrice;
    data['cart_item_qty'] = cartItemQty;
    data['total_price'] = totalPrice;
    data['image'] = image;
    return data;
  }
}
