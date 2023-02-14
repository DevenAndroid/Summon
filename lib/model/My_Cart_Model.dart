import 'package:get/get.dart';

class MyCartData {
  bool? status;
  String? message;
  Data? data;

  MyCartData({this.status, this.message, this.data});

  MyCartData.fromJson(Map<String, dynamic> json) {
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
  String? orderAddress;

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
  dynamic name;
  dynamic variantQty;
  dynamic variantQtyType;
  dynamic variantPrice;
  dynamic cartItemQty;
  dynamic totalPrice;
  dynamic image;
  RxInt qty = 1.obs;

  CartItems(
      {this.id,
      this.productId,
      this.name,
      this.variantQty,
      this.variantQtyType,
      this.variantPrice,
      this.cartItemQty,
      this.totalPrice,
      this.image,
        required this.qty,
      });

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
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
    data['product_id'] = this.productId;
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

class CartPaymentSummary {
  dynamic subTotal;
  dynamic couponDiscount;
  dynamic deliveryCharge;
  dynamic surCharge;
  dynamic packingFee;
  dynamic taxAndFee;
  dynamic total;

  CartPaymentSummary(
      {this.subTotal,
      this.couponDiscount,
      this.deliveryCharge,
      this.surCharge,
      this.packingFee,
      this.taxAndFee,
      this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    couponDiscount = json['couponDiscount'];
    deliveryCharge = json['deliveryCharge'];
    surCharge = json['surCharge'];
    packingFee = json['packingFee'];
    taxAndFee = json['taxAndFee'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['couponDiscount'] = this.couponDiscount;
    data['deliveryCharge'] = this.deliveryCharge;
    data['surCharge'] = this.surCharge;
    data['packingFee'] = this.packingFee;
    data['taxAndFee'] = this.taxAndFee;
    data['total'] = this.total;
    return data;
  }
}
