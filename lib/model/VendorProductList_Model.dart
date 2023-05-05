class VendorProductListModel {
  bool? status;
  String? message;
  List<Data>? data;

  VendorProductListModel({this.status, this.message, this.data});

  VendorProductListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic name;
  dynamic sKU;
  dynamic type;
  dynamic content;
  dynamic image;
  bool? status;
  List<Variants>? variants;
  List<Addons>? addons;

  Data(
      {this.id,
        this.name,
        this.sKU,
        this.type,
        this.content,
        this.image,
        this.status,
        this.variants,
        this.addons});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sKU = json['SKU'];
    type = json['type'];
    content = json['content'];
    image = json['image'];
    status = json['status'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['SKU'] = this.sKU;
    data['type'] = this.type;
    data['content'] = this.content;
    data['image'] = this.image;
    data['status'] = this.status;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  dynamic id;
  dynamic size;
  String? sizeName;
  dynamic price;
  dynamic minQty;
  dynamic maxQty;

  Variants(
      {this.id,
        this.size,
        this.sizeName,
        this.price,
        this.minQty,
        this.maxQty});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    sizeName = json['size_name'];
    price = json['price'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['size_name'] = this.sizeName;
    data['price'] = this.price;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    return data;
  }
}

class Addons {
  dynamic id;
  String? name;
  dynamic price;
  dynamic addonTypeId;
  dynamic addonType;

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
