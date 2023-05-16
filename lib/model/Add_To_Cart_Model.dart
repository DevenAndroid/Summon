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
  int? productId;
  int? variantId;
  String? name;
  int? sizeId;
  String? size;
  int? minQty;
  int? maxQty;
  String? variantPrice;
  int? cartItemQty;
  List<Addons>? addons;
  int? totalPrice;
  String? image;
  String? note;

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
        this.image,
        this.note});

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
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
    image = json['image'];
    note = json['note'];
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
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    data['note'] = this.note;
    return data;
  }
}

class Addons {
  int? id;
  String? name;
  String? calories;
  String? price;
  int? addonTypeId;
  String? addonType;
  bool? multiSelect;

  Addons(
      {this.id,
        this.name,
        this.calories,
        this.price,
        this.addonTypeId,
        this.addonType,
        this.multiSelect});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
    addonTypeId = json['addon_type_id'];
    addonType = json['addon_type'];
    multiSelect = json['multi_select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['price'] = this.price;
    data['addon_type_id'] = this.addonTypeId;
    data['addon_type'] = this.addonType;
    data['multi_select'] = this.multiSelect;
    return data;
  }
}
