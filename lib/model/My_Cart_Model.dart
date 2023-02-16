import 'package:get/get.dart';

class MyCartData {
  bool? status;
  String? message;
  Data? data;

  MyCartData({this.status, this.message, this.data});

  MyCartData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
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
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    cartPaymentSummary = json['cartPaymentSummary'] != null
        ? CartPaymentSummary.fromJson(json['cartPaymentSummary'])
        : null;
    orderAddress = json['orderAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    if (cartPaymentSummary != null) {
      data['cartPaymentSummary'] = cartPaymentSummary!.toJson();
    }
    data['orderAddress'] = orderAddress;
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
  dynamic variantId;
  RxInt? qty = 1.obs;

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
      this.variantId,
        this.qty,
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
    variantId = json['variant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['name'] = name;
    data['variant_qty'] = variantQty;
    data['variant_qty_type'] = variantQtyType;
    data['variant_price'] = variantPrice;
    data['cart_item_qty'] = cartItemQty;
    data['total_price'] = totalPrice;
    data['image'] = image;
    data['variant_id'] = variantId;
    return data;
  }
}

class CartPaymentSummary {
  dynamic subTotal;
  dynamic couponDiscount;
  dynamic couponCode;
  dynamic deliveryCharge;
  dynamic surCharge;
  dynamic tipAmount;
  dynamic packingFee;
  dynamic taxAndFee;
  dynamic total;

  CartPaymentSummary(
      {this.subTotal,
      this.couponDiscount,
      this.couponCode,
      this.deliveryCharge,
      this.surCharge,
      this.tipAmount,
      this.packingFee,
      this.taxAndFee,
      this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    couponDiscount = json['couponDiscount'];
    couponCode = json['couponCode'];
    deliveryCharge = json['deliveryCharge'];
    surCharge = json['surCharge'];
    tipAmount = json['tipAmount'];
    packingFee = json['packingFee'];
    taxAndFee = json['taxAndFee'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotal'] = subTotal;
    data['couponDiscount'] = couponDiscount;
    data['couponCode'] = couponCode;
    data['deliveryCharge'] = deliveryCharge;
    data['surCharge'] = surCharge;
    data['tipAmount'] = tipAmount;
    data['packingFee'] = packingFee;
    data['taxAndFee'] = taxAndFee;
    data['total'] = total;
    return data;
  }
}
