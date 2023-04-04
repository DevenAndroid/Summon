// class MyCartData {
//   bool? status;
//   String? message;
//   Data? data;
//
//   MyCartData({this.status, this.message, this.data});
//
//   MyCartData.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<CartItems>? cartItems;
//   CartPaymentSummary? cartPaymentSummary;
//   OrderAddress? orderAddress;
//
//   Data({this.cartItems, this.cartPaymentSummary, this.orderAddress});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['cartItems'] != null) {
//       cartItems = <CartItems>[];
//       json['cartItems'].forEach((v) {
//         cartItems!.add(CartItems.fromJson(v));
//       });
//     }
//     cartPaymentSummary = json['cartPaymentSummary'] != null
//         ? CartPaymentSummary.fromJson(json['cartPaymentSummary'])
//         : null;
//     orderAddress = json['orderAddress'] != null
//         ? OrderAddress.fromJson(json['orderAddress'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (cartItems != null) {
//       data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
//     }
//     if (cartPaymentSummary != null) {
//       data['cartPaymentSummary'] = cartPaymentSummary!.toJson();
//     }
//     if (orderAddress != null) {
//       data['orderAddress'] = orderAddress!.toJson();
//     }
//     return data;
//   }
// }
//
// class CartItems {
//   dynamic id;
//   dynamic productId;
//   dynamic variantId;
//   String? name;
//   dynamic variantQty;
//   String? variantQtyType;
//   dynamic variantPrice;
//   dynamic cartItemQty;
//   dynamic minQty;
//   dynamic maxQty;
//   dynamic totalPrice;
//   String? image;
//
//   CartItems(
//       {this.id,
//         this.productId,
//         this.variantId,
//         this.name,
//         this.variantQty,
//         this.variantQtyType,
//         this.variantPrice,
//         this.cartItemQty,
//         this.minQty,
//         this.maxQty,
//         this.totalPrice,
//         this.image});
//
//   CartItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     variantId = json['variant_id'];
//     name = json['name'];
//     variantQty = json['variant_qty'];
//     variantQtyType = json['variant_qty_type'];
//     variantPrice = json['variant_price'];
//     cartItemQty = json['cart_item_qty'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     totalPrice = json['total_price'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['product_id'] = productId;
//     data['variant_id'] = variantId;
//     data['name'] = name;
//     data['variant_qty'] = variantQty;
//     data['variant_qty_type'] = variantQtyType;
//     data['variant_price'] = variantPrice;
//     data['cart_item_qty'] = cartItemQty;
//     data['min_qty'] = minQty;
//     data['max_qty'] = maxQty;
//     data['total_price'] = totalPrice;
//     data['image'] = image;
//     return data;
//   }
// }
//
// class CartPaymentSummary {
//   dynamic subTotal;
//   dynamic couponDiscount;
//   dynamic couponCode;
//   dynamic deliveryCharge;
//   dynamic surCharge;
//   dynamic tipAmount;
//   dynamic packingFee;
//   dynamic taxAndFee;
//   dynamic total;
//
//   CartPaymentSummary(
//       {this.subTotal,
//         this.couponDiscount,
//         this.couponCode,
//         this.deliveryCharge,
//         this.surCharge,
//         this.tipAmount,
//         this.packingFee,
//         this.taxAndFee,
//         this.total});
//
//   CartPaymentSummary.fromJson(Map<String, dynamic> json) {
//     subTotal = json['subTotal'];
//     couponDiscount = json['couponDiscount'];
//     couponCode = json['couponCode'];
//     deliveryCharge = json['deliveryCharge'];
//     surCharge = json['surCharge'];
//     tipAmount = json['tipAmount'];
//     packingFee = json['packingFee'];
//     taxAndFee = json['taxAndFee'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['subTotal'] = subTotal;
//     data['couponDiscount'] = couponDiscount;
//     data['couponCode'] = couponCode;
//     data['deliveryCharge'] = deliveryCharge;
//     data['surCharge'] = surCharge;
//     data['tipAmount'] = tipAmount;
//     data['packingFee'] = packingFee;
//     data['taxAndFee'] = taxAndFee;
//     data['total'] = total;
//     return data;
//   }
// }
//
// class OrderAddress {
//   int? id;
//   int? userId;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic location;
//   dynamic flatNo;
//   dynamic street;
//   dynamic landmark;
//   dynamic addressType;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic deletedAt;
//
//   OrderAddress(
//       {this.id,
//         this.userId,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.flatNo,
//         this.street,
//         this.landmark,
//         this.addressType,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt});
//
//   OrderAddress.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     flatNo = json['flat_no'];
//     street = json['street'];
//     landmark = json['landmark'];
//     addressType = json['address_type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['location'] = location;
//     data['flat_no'] = flatNo;
//     data['street'] = street;
//     data['landmark'] = landmark;
//     data['address_type'] = addressType;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['deleted_at'] = deletedAt;
//     return data;
//   }
// }



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
  OrderAddress? orderAddress;

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
    orderAddress = json['orderAddress'] != null
        ? new OrderAddress.fromJson(json['orderAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.cartPaymentSummary != null) {
      data['cartPaymentSummary'] = this.cartPaymentSummary!.toJson();
    }
    if (this.orderAddress != null) {
      data['orderAddress'] = this.orderAddress!.toJson();
    }
    return data;
  }
}

class CartItems {
  int? id;
  int? productId;
  int? variantId;
  dynamic name;
  dynamic variantQty;
  dynamic variantQtyType;
  dynamic minQty;
  dynamic maxQty;
  dynamic variantPrice;
  dynamic cartItemQty;
  dynamic totalPrice;
  String? image;

  CartItems(
      {this.id,
        this.productId,
        this.variantId,
        this.name,
        this.variantQty,
        this.variantQtyType,
        this.minQty,
        this.maxQty,
        this.variantPrice,
        this.cartItemQty,
        this.totalPrice,
        this.image});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    variantId = json['variant_id'];
    name = json['name'];
    variantQty = json['variant_qty'];
    variantQtyType = json['variant_qty_type'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    variantPrice = json['variant_price'];
    cartItemQty = json['cart_item_qty'];
    totalPrice = json['total_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['variant_id'] = this.variantId;
    data['name'] = this.name;
    data['variant_qty'] = this.variantQty;
    data['variant_qty_type'] = this.variantQtyType;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    data['variant_price'] = this.variantPrice;
    data['cart_item_qty'] = this.cartItemQty;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    return data;
  }
}

class CartPaymentSummary {
  dynamic adminCommisssion;
  dynamic subTotal;
  dynamic couponDiscount;
  dynamic couponCode;
  dynamic deliveryCharge;
  dynamic surCharge;
  dynamic tipAmount;
  dynamic packingFee;
  dynamic taxAndFee;
  Tax1? tax1;
  Tax2? tax2;
  dynamic total;

  CartPaymentSummary(
      {this.adminCommisssion,
        this.subTotal,
        this.couponDiscount,
        this.couponCode,
        this.deliveryCharge,
        this.surCharge,
        this.tipAmount,
        this.packingFee,
        this.taxAndFee,
        this.tax1,
        this.tax2,
        this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    adminCommisssion = json['adminCommisssion'];
    subTotal = json['subTotal'];
    couponDiscount = json['couponDiscount'];
    couponCode = json['couponCode'];
    deliveryCharge = json['deliveryCharge'];
    surCharge = json['surCharge'];
    tipAmount = json['tipAmount'];
    packingFee = json['packingFee'];
    taxAndFee = json['taxAndFee'];
    tax1 = json['tax_1'] != null ? new Tax1.fromJson(json['tax_1']) : null;
    tax2 = json['tax_2'] != null ? new Tax2.fromJson(json['tax_2']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminCommisssion'] = this.adminCommisssion;
    data['subTotal'] = this.subTotal;
    data['couponDiscount'] = this.couponDiscount;
    data['couponCode'] = this.couponCode;
    data['deliveryCharge'] = this.deliveryCharge;
    data['surCharge'] = this.surCharge;
    data['tipAmount'] = this.tipAmount;
    data['packingFee'] = this.packingFee;
    data['taxAndFee'] = this.taxAndFee;
    if (this.tax1 != null) {
      data['tax_1'] = this.tax1!.toJson();
    }
    if (this.tax2 != null) {
      data['tax_2'] = this.tax2!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Tax1 {
  String? type;
  double? amount;

  Tax1({this.type, this.amount});

  Tax1.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    return data;
  }
}


class Tax2 {
  String? type;
  double? amount;

  Tax2({this.type, this.amount});

  Tax2.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    return data;
  }
}

class OrderAddress {
  int? id;
  int? userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic street;
  dynamic landmark;
  dynamic addressType;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  OrderAddress(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.street,
        this.landmark,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  OrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    street = json['street'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['street'] = this.street;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
