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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['variant_qty'] = this.variantQty;
    data['variant_qty_type'] = this.variantQtyType;
    data['variant_price'] = this.variantPrice;
    data['cart_item_qty'] = this.cartItemQty;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    return data;
  }
}
