class MyCartDataModel1 {
  bool? status;
  String? message;
  Data? data;

  MyCartDataModel1({this.status, this.message, this.data});

  MyCartDataModel1.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CartItems>? cartItems;
  CartPaymentSummary? cartPaymentSummary;
  Null? orderAddress;

  Data({this.cartItems, this.cartPaymentSummary, this.orderAddress});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    cartPaymentSummary = json['cartPaymentSummary'] != null
        ? new CartPaymentSummary.fromJson(json['cartPaymentSummary'])
        : null;
    orderAddress = json['orderAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.cartPaymentSummary != null) {
      data['cartPaymentSummary'] = this.cartPaymentSummary!.toJson();
    }
    data['orderAddress'] = this.orderAddress;
    return data;
  }
}

class CartItems {
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
  List<Addons>? addons;
  dynamic totalPrice;
  String? image;
  dynamic note;

  CartItems(
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

  CartItems.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic name;
  dynamic calories;
  dynamic price;
  dynamic addonTypeId;
  dynamic addonType;
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

class CartPaymentSummary {
  dynamic subTotal;
  dynamic couponDiscount;
  dynamic couponCode;
  dynamic deliveryCharge;
  dynamic walletSaving;
  dynamic total;

  CartPaymentSummary(
      {this.subTotal,
        this.couponDiscount,
        this.couponCode,
        this.deliveryCharge,
        this.walletSaving,
        this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    couponDiscount = json['couponDiscount'];
    couponCode = json['couponCode'];
    deliveryCharge = json['deliveryCharge'];
    walletSaving = json['walletSaving'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['couponDiscount'] = this.couponDiscount;
    data['couponCode'] = this.couponCode;
    data['deliveryCharge'] = this.deliveryCharge;
    data['walletSaving'] = this.walletSaving;
    data['total'] = this.total;
    return data;
  }
}
