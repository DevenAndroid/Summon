// To parse this JSON data, do
//
//     final vendorProductListModel = vendorProductListModelFromJson(jsonString);

import 'dart:convert';

VendorProductListModel vendorProductListModelFromJson(String str) =>
    VendorProductListModel.fromJson(json.decode(str));

String vendorProductListModelToJson(VendorProductListModel data) =>
    json.encode(data.toJson());

class VendorProductListModel {
  VendorProductListModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory VendorProductListModel.fromJson(Map<String, dynamic> json) =>
      VendorProductListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.product,
    this.image,
    this.status,
    this.variants,
  });

  int? id;
  Product? product;
  String? image;
  bool? status;
  List<Variant>? variants;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        image: json["image"],
        status: json["status"],
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "image": image,
        "status": status,
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.category,
    this.tax,
    this.sku,
    this.name,
    this.qty,
    this.qtyType,
    this.minQty,
    this.maxQty,
    this.marketPrice,
    this.regularPrice,
    this.content,
    this.image,
  });

  int? id;
  Category? category;
  dynamic tax;
  String? sku;
  String? name;
  String? qty;
  String? qtyType;
  String? minQty;
  String? maxQty;
  String? marketPrice;
  String? regularPrice;
  String? content;
  String? image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        tax: json["tax"],
        sku: json["SKU"],
        name: json["name"],
        qty: json["qty"],
        qtyType: json["qty_type"],
        minQty: json["min_qty"],
        maxQty: json["max_qty"],
        marketPrice: json["market_price"],
        regularPrice: json["regular_price"],
        content: json["content"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category?.toJson(),
        "tax": tax,
        "SKU": sku,
        "name": name,
        "qty": qty,
        "qty_type": qtyType,
        "min_qty": minQty,
        "max_qty": maxQty,
        "market_price": marketPrice,
        "regular_price": regularPrice,
        "content": content,
        "image": image,
      };
}

class Category {
  Category({
    this.id,
    this.tax,
    this.name,
    this.slug,
    this.image,
    this.status,
  });

  int? id;
  TaxClass? tax;
  String? name;
  String? slug;
  String? image;
  bool? status;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        tax: json["tax"] == null ? null : TaxClass.fromJson(json["tax"]),
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tax": tax?.toJson(),
        "name": name,
        "slug": slug,
        "image": image,
        "status": status,
      };
}

class TaxClass {
  TaxClass({
    this.id,
    this.title,
    this.taxPercent,
    this.status,
  });

  int? id;
  String? title;
  dynamic taxPercent;
  bool? status;

  factory TaxClass.fromJson(Map<String, dynamic> json) => TaxClass(
        id: json["id"],
        title: json["title"],
        taxPercent: json["tax_percent"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tax_percent": taxPercent,
        "status": status,
      };
}

class Variant {
  Variant({
    this.id,
    this.vendorProductId,
    this.marketPrice,
    this.price,
    this.variantQty,
    this.variantQtyType,
    this.minQty,
    this.maxQty,
    this.discountOff,
  });

  int? id;
  dynamic vendorProductId;
  dynamic marketPrice;
  dynamic price;
  dynamic variantQty;
  dynamic variantQtyType;
  dynamic minQty;
  dynamic maxQty;
  dynamic discountOff;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        vendorProductId: json["vendor_product_id"],
        marketPrice: json["market_price"],
        price: json["price"],
        variantQty: json["variant_qty"],
        variantQtyType: json["variant_qty_type"],
        minQty: json["min_qty"],
        maxQty: json["max_qty"],
        discountOff: json["discount_off"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_product_id": vendorProductId,
        "market_price": marketPrice,
        "price": price,
        "variant_qty": variantQty,
        "variant_qty_type": variantQtyType,
        "min_qty": minQty,
        "max_qty": maxQty,
        "discount_off": discountOff,
      };
}
