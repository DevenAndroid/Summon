class ToggleStatusModel {
  bool? status;
  String? message;
  Data? data;

  ToggleStatusModel({this.status, this.message, this.data});

  ToggleStatusModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  Vendor? vendor;
  Product? product;
  String? image;
  bool? status;
  List<ProductsVariant>? productsVariant;

  Data(
      {this.id,
      this.vendor,
      this.product,
      this.image,
      this.status,
      this.productsVariant});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor =
        json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    image = json['image'];
    status = json['status'];
    if (json['products_variant'] != null) {
      productsVariant = <ProductsVariant>[];
      json['products_variant'].forEach((v) {
        productsVariant!.add(new ProductsVariant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['image'] = this.image;
    data['status'] = this.status;
    if (this.productsVariant != null) {
      data['products_variant'] =
          this.productsVariant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
  int? id;
  bool? isDriver;
  bool? isVendor;
  String? latitude;
  String? longitude;
  String? location;
  String? name;
  String? email;
  String? phone;
  String? walletBalance;
  String? earnedBalance;
  String? profileImage;
  String? referalCode;
  bool? isDriverOnline;
  bool? isVendorOnline;
  int? deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? isProfileComplete;

  Vendor(
      {this.id,
      this.isDriver,
      this.isVendor,
      this.latitude,
      this.longitude,
      this.location,
      this.name,
      this.email,
      this.phone,
      this.walletBalance,
      this.earnedBalance,
      this.profileImage,
      this.referalCode,
      this.isDriverOnline,
      this.isVendorOnline,
      this.deliveryRange,
      this.selfDelivery,
      this.asDriverVerified,
      this.asVendorVerified,
      this.isProfileComplete});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    profileImage = json['profile_image'];
    referalCode = json['referal_code'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    isProfileComplete = json['is_profile_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['profile_image'] = this.profileImage;
    data['referal_code'] = this.referalCode;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['is_profile_complete'] = this.isProfileComplete;
    return data;
  }
}

class Product {
  int? id;
  Category? category;
  String? tax;
  String? sKU;
  String? name;
  String? qty;
  String? qtyType;
  String? marketPrice;
  String? regularPrice;
  String? content;
  String? image;

  Product(
      {this.id,
      this.category,
      this.tax,
      this.sKU,
      this.name,
      this.qty,
      this.qtyType,
      this.marketPrice,
      this.regularPrice,
      this.content,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    tax = json['tax'];
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
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['tax'] = this.tax;
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

class Category {
  int? id;
  Tax? tax;
  String? name;
  String? slug;
  String? image;
  bool? status;

  Category({this.id, this.tax, this.name, this.slug, this.image, this.status});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.tax != null) {
      data['tax'] = this.tax!.toJson();
    }
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class Tax {
  int? id;
  String? title;
  int? taxPercent;
  bool? status;

  Tax({this.id, this.title, this.taxPercent, this.status});

  Tax.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    taxPercent = json['tax_percent'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.status;
    return data;
  }
}

class ProductsVariant {
  int? id;
  int? vendorProductId;
  int? marketPrice;
  int? price;
  String? variantQty;
  String? variantQtyType;
  int? minQty;
  int? maxQty;
  String? discountOff;

  ProductsVariant(
      {this.id,
      this.vendorProductId,
      this.marketPrice,
      this.price,
      this.variantQty,
      this.variantQtyType,
      this.minQty,
      this.maxQty,
      this.discountOff});

  ProductsVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorProductId = json['vendor_product_id'];
    marketPrice = json['market_price'];
    price = json['price'];
    variantQty = json['variant_qty'];
    variantQtyType = json['variant_qty_type'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    discountOff = json['discount_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_product_id'] = this.vendorProductId;
    data['market_price'] = this.marketPrice;
    data['price'] = this.price;
    data['variant_qty'] = this.variantQty;
    data['variant_qty_type'] = this.variantQtyType;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    data['discount_off'] = this.discountOff;
    return data;
  }
}
