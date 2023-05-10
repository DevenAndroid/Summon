class ViewAllRecommendedModel {
  bool? status;
  String? message;
  List<Data>? data;
  Meta? meta;
  Link? link;

  ViewAllRecommendedModel(
      {this.status, this.message, this.data, this.meta, this.link});

  ViewAllRecommendedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? sKU;
  String? type;
  String? content;
  String? image;
  bool? wishlist;
  bool? status;
  List<Variants>? variants;
  List<Addons>? addons;
  String? avgRating;

  Data(
      {this.id,
        this.name,
        this.sKU,
        this.type,
        this.content,
        this.image,
        this.wishlist,
        this.status,
        this.variants,
        this.addons,
        this.avgRating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sKU = json['SKU'];
    type = json['type'];
    content = json['content'];
    image = json['image'];
    wishlist = json['wishlist'];
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
    data['wishlist'] = this.wishlist;
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

class Meta {
  int? totalPage;
  int? currentPage;
  int? totalItem;
  int? perPage;

  Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    totalItem = json['total_item'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['total_item'] = this.totalItem;
    data['per_page'] = this.perPage;
    return data;
  }
}

class Link {
  bool? next;
  bool? prev;

  Link({this.next, this.prev});

  Link.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}
