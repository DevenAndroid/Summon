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
  dynamic id;
  dynamic productId;
  dynamic variantId;
  dynamic name;
  dynamic sizeId;
  dynamic size;
  dynamic minQty;
  dynamic maxQty;
  dynamic variantPrice;
  dynamic cartItemQty;
  Addons? addons;
  dynamic totalPrice;
  String? image;

  Data(
      {this.id,
        this.productId,
        this.variantId,
        this.name,
        this.sizeId,
        this.size,
        this.minQty,
        this.maxQty,
        this.variantPrice,
        this.cartItemQty,
        this.addons,
        this.totalPrice,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    variantId = json['variant_id'];
    name = json['name'];
    sizeId = json['size_id'];
    size = json['size'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    variantPrice = json['variant_price'];
    cartItemQty = json['cart_item_qty'];
    addons =
    json['addons'] != null ? new Addons.fromJson(json['addons']) : null;
    totalPrice = json['total_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['variant_id'] = this.variantId;
    data['name'] = this.name;
    data['size_id'] = this.sizeId;
    data['size'] = this.size;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    data['variant_price'] = this.variantPrice;
    data['cart_item_qty'] = this.cartItemQty;
    if (this.addons != null) {
      data['addons'] = this.addons!.toJson();
    }
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    return data;
  }
}

class Addons {
  int? id;
  String? name;
  String? price;
  int? addonTypeId;
  String? addonType;

  Addons({this.id, this.name, this.price, this.addonTypeId, this.addonType});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    addonTypeId = json['addon_type_id'];
    addonType = json['addon_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['addon_type_id'] = this.addonTypeId;
    data['addon_type'] = this.addonType;
    return data;
  }
}
