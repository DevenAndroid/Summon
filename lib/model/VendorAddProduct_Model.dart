class VendorAddProductModel {
  bool? status;
  String? message;
  Data? data;

  VendorAddProductModel({this.status, this.message, this.data});

  VendorAddProductModel.fromJson(Map<String, dynamic> json) {
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
  Category? category;
  Tax? tax;
  String? sKU;
  String? name;
  String? qty;
  String? qtyType;
  String? minQty;
  String? maxQty;
  String? marketPrice;
  String? regularPrice;
  String? content;
  String? image;

  Data(
      {this.id,
      this.category,
      this.tax,
      this.sKU,
      this.name,
      this.qty,
      this.qtyType,
      this.minQty,
      this.maxQty,
      this.marketPrice,
      this.regularPrice,
      this.content,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
    sKU = json['SKU'];
    name = json['name'];
    qty = json['qty'];
    qtyType = json['qty_type'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
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
    if (this.tax != null) {
      data['tax'] = this.tax!.toJson();
    }
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['qty_type'] = this.qtyType;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
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
