// class VendorAddProductModel {
//   bool? status;
//   dynamic message;
//   Data? data;
//
//   VendorAddProductModel({this.status, this.message, this.data});
//
//   VendorAddProductModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic id;
//   Category? category;
//   Tax? tax;
//   dynamic sKU;
//   dynamic name;
//   dynamic qty;
//   dynamic qtyType;
//   dynamic minQty;
//   dynamic maxQty;
//   dynamic marketPrice;
//   dynamic regularPrice;
//   dynamic content;
//   dynamic image;
//
//   Data(
//       {this.id,
//       this.category,
//       this.tax,
//       this.sKU,
//       this.name,
//       this.qty,
//       this.qtyType,
//       this.minQty,
//       this.maxQty,
//       this.marketPrice,
//       this.regularPrice,
//       this.content,
//       this.image});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     category = json['category'] != null
//         ? new Category.fromJson(json['category'])
//         : null;
//     tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
//     sKU = json['SKU'];
//     name = json['name'];
//     qty = json['qty'];
//     qtyType = json['qty_type'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     marketPrice = json['market_price'];
//     regularPrice = json['regular_price'];
//     content = json['content'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.category != null) {
//       data['category'] = this.category!.toJson();
//     }
//     if (this.tax != null) {
//       data['tax'] = this.tax!.toJson();
//     }
//     data['SKU'] = this.sKU;
//     data['name'] = this.name;
//     data['qty'] = this.qty;
//     data['qty_type'] = this.qtyType;
//     data['min_qty'] = this.minQty;
//     data['max_qty'] = this.maxQty;
//     data['market_price'] = this.marketPrice;
//     data['regular_price'] = this.regularPrice;
//     data['content'] = this.content;
//     data['image'] = this.image;
//     return data;
//   }
// }
//
// class Category {
//   dynamic id;
//   Tax? tax;
//   dynamic name;
//   dynamic slug;
//   dynamic image;
//   bool? status;
//
//   Category({this.id, this.tax, this.name, this.slug, this.image, this.status});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
//     name = json['name'];
//     slug = json['slug'];
//     image = json['image'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.tax != null) {
//       data['tax'] = this.tax!.toJson();
//     }
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['image'] = this.image;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class Tax {
//   dynamic id;
//   dynamic title;
//   dynamic taxPercent;
//   bool? status;
//
//   Tax({this.id, this.title, this.taxPercent, this.status});
//
//   Tax.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     taxPercent = json['tax_percent'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['tax_percent'] = this.taxPercent;
//     data['status'] = this.status;
//     return data;
//   }
// }
class VendorAddProductModel {
  bool? status;
  dynamic message;
  VendorAddProductData? data;

  VendorAddProductModel({this.status, this.message, this.data});

  VendorAddProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new VendorAddProductData.fromJson(json['data']) : null;
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

class VendorAddProductData {
  ProductDetail? productDetail;
  List<SinglePageAddons>? singlePageAddons = [];

  VendorAddProductData({this.productDetail, this.singlePageAddons});

  VendorAddProductData.fromJson(Map<String, dynamic> json) {
    productDetail = json['product_detail'] != null
        ? new ProductDetail.fromJson(json['product_detail'])
        : null;
    if (json['single_page_addons'] != null) {
      singlePageAddons = <SinglePageAddons>[];
      json['single_page_addons'].forEach((v) {
        singlePageAddons!.add(new SinglePageAddons.fromJson(v));
      });
    } else{
      singlePageAddons = [];
    }
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
    return data;
  }
}

class ProductDetail {
  dynamic id;
  dynamic name;
  dynamic sKU;
  dynamic calories;
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
        this.calories,
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
    calories = json['calories'];
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
    data['calories'] = this.calories;
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
  dynamic id;
  dynamic title;
  dynamic name;
  dynamic calories;
  dynamic price;
  bool? multiSelect;

  Addons(
      {this.id,
        this.title,
        this.name,
        this.calories,
        this.price,
        this.multiSelect});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
    multiSelect = json['multi_select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['price'] = this.price;
    data['multi_select'] = this.multiSelect;
    return data;
  }
}

class SinglePageAddons {
  dynamic title;
  bool? multiSelectAddons;
  List<AddonData>? addonData;

  SinglePageAddons({this.title, this.multiSelectAddons, this.addonData});

  SinglePageAddons.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    multiSelectAddons = json['multi_select_addons'];
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
    data['multi_select_addons'] = this.multiSelectAddons;
    if (this.addonData != null) {
      data['addon_data'] = this.addonData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddonData {
  dynamic id;
  dynamic name;
  dynamic calories;
  dynamic price;
  bool? multiSelect;

  AddonData({this.id, this.name, this.calories, this.price, this.multiSelect});

  AddonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    calories = json['calories'];
    price = json['price'];
    multiSelect = json['multi_select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['price'] = this.price;
    data['multi_select'] = this.multiSelect;
    return data;
  }
}
