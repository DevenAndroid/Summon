class SingleProductModel {
  bool? status;
  String? message;
  Data? data;

  SingleProductModel({this.status, this.message, this.data});

  SingleProductModel.fromJson(Map<String, dynamic> json) {
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
  ProductDetail? productDetail;
  List<SinglePageAddons>? singlePageAddons;
  int? addonLimit;

  Data({this.productDetail, this.singlePageAddons, this.addonLimit});

  Data.fromJson(Map<String, dynamic> json) {
    productDetail = json['product_detail'] != null
        ? new ProductDetail.fromJson(json['product_detail'])
        : null;
    if (json['single_page_addons'] != null) {
      singlePageAddons = <SinglePageAddons>[];
      json['single_page_addons'].forEach((v) {
        singlePageAddons!.add(new SinglePageAddons.fromJson(v));
      });
    }
    addonLimit = json['addon_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetail != null) {
      data['product_detail'] = this.productDetail!.toJson();
    }
    if (this.singlePageAddons != null) {
      data['single_page_addons'] =
          this.singlePageAddons!.map((v) => v.toJson()).toList();
    }
    data['addon_limit'] = this.addonLimit;
    return data;
  }
}

class ProductDetail {
  dynamic id;
  dynamic name;
  dynamic sKU;
  dynamic type;
  dynamic content;
  dynamic image;
  bool? status;
  List<Variants>? variants;
  List<Addons>? addons;
  dynamic avgRating;

  ProductDetail(
      {this.id,
        this.name,
        this.sKU,
        this.type,
        this.content,
        this.image,
        this.status,
        this.variants,
        this.addons,
        this.avgRating});

  ProductDetail.fromJson(Map<String, dynamic> json) {
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
    avgRating = json['avg_rating'];
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
    data['avg_rating'] = this.avgRating;
    return data;
  }
}

class Variants {
  dynamic id;
  dynamic size;
  dynamic sizeName;
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

class SinglePageAddons {
  String? title;
  String selectedAddon = "";
  List<AddonData>? addonData;

  SinglePageAddons({this.title, this.addonData});

  SinglePageAddons.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['addon_data'] != null) {
      addonData = <AddonData>[];
      json['addon_data'].forEach((v) {
        addonData!.add(new AddonData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.addonData != null) {
      data['addon_data'] = this.addonData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddonData {
  int? id;
  String? name;
  String? price;

  AddonData({this.id, this.name, this.price});

  AddonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
