import 'package:get/get.dart';

// class StoreDetailsModel {
//   bool? status;
//   dynamic message;
//   Data? data;
//
//   StoreDetailsModel({this.status, this.message, this.data});
//
//   StoreDetailsModel.fromJson(Map<String, dynamic> json) {
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
//   StoreDetails? storeDetails;
//   List<LatestProducts>? latestProducts;
//
//   Data({this.storeDetails, this.latestProducts});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     storeDetails = json['storeDetails'] != null
//         ? new StoreDetails.fromJson(json['storeDetails'])
//         : null;
//     if (json['LatestProducts'] != null) {
//       latestProducts = <LatestProducts>[];
//       json['LatestProducts'].forEach((v) {
//         latestProducts!.add(new LatestProducts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.storeDetails != null) {
//       data['storeDetails'] = this.storeDetails!.toJson();
//     }
//     if (this.latestProducts != null) {
//       data['LatestProducts'] =
//           this.latestProducts!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class StoreDetails {
//   dynamic id;
//   dynamic storeName;
//   dynamic storeImage;
//
//   StoreDetails({this.id, this.storeName, this.storeImage});
//
//   StoreDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     storeName = json['store_name'];
//     storeImage = json['store_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['store_name'] = this.storeName;
//     data['store_image'] = this.storeImage;
//     return data;
//   }
// }
//
// class LatestProducts {
//   dynamic id;
//   dynamic name;
//   dynamic image;
//   List<Varints>? varints;
//   Rxdynamic varientIndex = (0).obs;
//   LatestProducts({this.id, this.name, this.image, this.varints,this.varientIndex});
//
//   LatestProducts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     if (json['varints'] != null) {
//       varints = <Varints>[];
//       json['varints'].forEach((v) {
//         varints!.add(new Varints.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     if (this.varints != null) {
//       data['varints'] = this.varints!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Varints {
//   dynamic id;
//   dynamic vendorProductId;
//   dynamic marketPrice;
//   dynamic price;
//   dynamic variantQty;
//   dynamic variantQtyType;
//   dynamic minQty;
//   dynamic maxQty;
//   dynamic discountOff;
//
//   Varints(
//       {this.id,
//       this.vendorProductId,
//       this.marketPrice,
//       this.price,
//       this.variantQty,
//       this.variantQtyType,
//       this.minQty,
//       this.maxQty,
//       this.discountOff});
//
//   Varints.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorProductId = json['vendor_product_id'];
//     marketPrice = json['market_price'];
//     price = json['price'];
//     variantQty = json['variant_qty'];
//     variantQtyType = json['variant_qty_type'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     discountOff = json['discount_off'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_product_id'] = this.vendorProductId;
//     data['market_price'] = this.marketPrice;
//     data['price'] = this.price;
//     data['variant_qty'] = this.variantQty;
//     data['variant_qty_type'] = this.variantQtyType;
//     data['min_qty'] = this.minQty;
//     data['max_qty'] = this.maxQty;
//     data['discount_off'] = this.discountOff;
//     return data;
//   }
// }

//
// class StoreDetailsModel {
//   bool? status;
//   dynamic message;
//   Data? data;
//   Meta? meta;
//   Link? link;
//
//   StoreDetailsModel(
//       {this.status, this.message, this.data, this.meta, this.link});
//
//   StoreDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//     link = json['link'] != null ? new Link.fromJson(json['link']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     if (this.link != null) {
//       data['link'] = this.link!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   StoreDetails? storeDetails;
//   List<LatestProducts>? latestProducts=[];
//
//   Data({this.storeDetails, this.latestProducts});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     storeDetails = json['storeDetails'] != null
//         ? new StoreDetails.fromJson(json['storeDetails'])
//         : null;
//     if (json['LatestProducts'] != null) {
//       latestProducts = <LatestProducts>[];
//       json['LatestProducts'].forEach((v) {
//         latestProducts!.add(new LatestProducts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.storeDetails != null) {
//       data['storeDetails'] = this.storeDetails!.toJson();
//     }
//     if (this.latestProducts != null) {
//       data['LatestProducts'] =
//           this.latestProducts!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class StoreDetails {
//   dynamic id;
//   dynamic storeName;
//   dynamic storeImage;
//
//   StoreDetails({this.id, this.storeName, this.storeImage});
//
//   StoreDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     storeName = json['store_name'];
//     storeImage = json['store_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['store_name'] = this.storeName;
//     data['store_image'] = this.storeImage;
//     return data;
//   }
// }
//
// class LatestProducts {
//   dynamic id;
//   dynamic name;
//   dynamic image;
//   Rxdynamic varientIndex = (0).obs;
//   List<Varints>? varints;
//
//   LatestProducts({this.id, this.name, this.image, this.varints});
//
//   LatestProducts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     if (json['varints'] != null) {
//       varints = <Varints>[];
//       json['varints'].forEach((v) {
//         varints!.add(new Varints.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     if (this.varints != null) {
//       data['varints'] = this.varints!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Varints {
//   dynamic id;
//   dynamic vendorProductId;
//   dynamic marketPrice;
//   dynamic price;
//   dynamic variantQty;
//   dynamic variantQtyType;
//   dynamic minQty;
//   dynamic maxQty;
//   dynamic discountOff;
//
//   Varints(
//       {this.id,
//         this.vendorProductId,
//         this.marketPrice,
//         this.price,
//         this.variantQty,
//         this.variantQtyType,
//         this.minQty,
//         this.maxQty,
//         this.discountOff});
//
//   Varints.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorProductId = json['vendor_product_id'];
//     marketPrice = json['market_price'];
//     price = json['price'];
//     variantQty = json['variant_qty'];
//     variantQtyType = json['variant_qty_type'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     discountOff = json['discount_off'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_product_id'] = this.vendorProductId;
//     data['market_price'] = this.marketPrice;
//     data['price'] = this.price;
//     data['variant_qty'] = this.variantQty;
//     data['variant_qty_type'] = this.variantQtyType;
//     data['min_qty'] = this.minQty;
//     data['max_qty'] = this.maxQty;
//     data['discount_off'] = this.discountOff;
//     return data;
//   }
// }
//
// class Meta {
//   dynamic totalPage;
//   dynamic currentPage;
//   dynamic totalItem;
//   dynamic perPage;
//
//   Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     totalPage = json['total_page'];
//     currentPage = json['current_page'];
//     totalItem = json['total_item'];
//     perPage = json['per_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_page'] = this.totalPage;
//     data['current_page'] = this.currentPage;
//     data['total_item'] = this.totalItem;
//     data['per_page'] = this.perPage;
//     return data;
//   }
// }
//
// class Link {
//   bool? next;
//   bool? prev;
//
//   Link({this.next, this.prev});
//
//   Link.fromJson(Map<String, dynamic> json) {
//     next = json['next'];
//     prev = json['prev'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['next'] = this.next;
//     data['prev'] = this.prev;
//     return data;
//   }
// }
// class StoreDetailsModel {
//   bool? status;
//   dynamic message;
//   Data? data;
//   Meta? meta;
//   Link? link;
//
//   StoreDetailsModel(
//       {this.status, this.message, this.data, this.meta, this.link});
//
//   StoreDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//     link = json['link'] != null ? new Link.fromJson(json['link']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     if (this.link != null) {
//       data['link'] = this.link!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   StoreDetails? storeDetails;
//   List<LatestProducts>? latestProducts;
//
//   Data({this.storeDetails, this.latestProducts});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     storeDetails = json['storeDetails'] != null
//         ? new StoreDetails.fromJson(json['storeDetails'])
//         : null;
//     if (json['LatestProducts'] != null) {
//       latestProducts = <LatestProducts>[];
//       json['LatestProducts'].forEach((v) {
//         latestProducts!.add(new LatestProducts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.storeDetails != null) {
//       data['storeDetails'] = this.storeDetails!.toJson();
//     }
//     if (this.latestProducts != null) {
//       data['LatestProducts'] =
//           this.latestProducts!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class StoreDetails {
//   dynamic id;
//   dynamic storeName;
//   dynamic phone;
//   bool? importedMeat;
//   bool? importedChicken;
//   dynamic storeImage;
//   dynamic distance;
//   dynamic availability;
//
//   StoreDetails(
//       {this.id,
//         this.storeName,
//         this.phone,
//         this.importedMeat,
//         this.importedChicken,
//         this.storeImage,
//         this.distance,
//         this.availability});
//
//   StoreDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     storeName = json['store_name'];
//     phone = json['phone'];
//     importedMeat = json['imported_meat'];
//     importedChicken = json['imported_chicken'];
//     storeImage = json['store_image'];
//     distance = json['distance'];
//     availability = json['availability'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['store_name'] = this.storeName;
//     data['phone'] = this.phone;
//     data['imported_meat'] = this.importedMeat;
//     data['imported_chicken'] = this.importedChicken;
//     data['store_image'] = this.storeImage;
//     data['distance'] = this.distance;
//     data['availability'] = this.availability;
//     return data;
//   }
// }
//
// class LatestProducts {
//   dynamic id;
//   dynamic name;
//   dynamic image;
//   List<Varints>? varints;
//
//   LatestProducts({this.id, this.name, this.image, this.varints});
//
//   LatestProducts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     if (json['varints'] != null) {
//       varints = <Varints>[];
//       json['varints'].forEach((v) {
//         varints!.add(new Varints.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     if (this.varints != null) {
//       data['varints'] = this.varints!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Varints {
//   dynamic id;
//   dynamic size;
//   dynamic sizeName;
//   dynamic price;
//   dynamic minQty;
//   dynamic maxQty;
//
//   Varints(
//       {this.id,
//         this.size,
//         this.sizeName,
//         this.price,
//         this.minQty,
//         this.maxQty});
//
//   Varints.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     size = json['size'];
//     sizeName = json['size_name'];
//     price = json['price'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['size'] = this.size;
//     data['size_name'] = this.sizeName;
//     data['price'] = this.price;
//     data['min_qty'] = this.minQty;
//     data['max_qty'] = this.maxQty;
//     return data;
//   }
// }
//
// class Meta {
//   dynamic totalPage;
//   dynamic currentPage;
//   dynamic totalItem;
//   dynamic perPage;
//
//   Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     totalPage = json['total_page'];
//     currentPage = json['current_page'];
//     totalItem = json['total_item'];
//     perPage = json['per_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_page'] = this.totalPage;
//     data['current_page'] = this.currentPage;
//     data['total_item'] = this.totalItem;
//     data['per_page'] = this.perPage;
//     return data;
//   }
// }
//
// class Link {
//   bool? next;
//   bool? prev;
//
//   Link({this.next, this.prev});
//
//   Link.fromJson(Map<String, dynamic> json) {
//     next = json['next'];
//     prev = json['prev'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['next'] = this.next;
//     data['prev'] = this.prev;
//     return data;
//   }
// }
class StoreDetailsModel {
  bool? status;
  dynamic message;
  Data? data;
  Meta? meta;
  Link? link;

  StoreDetailsModel(
      {this.status, this.message, this.data, this.meta, this.link});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  StoreDetails? storeDetails;
  List<LatestProducts>? latestProducts;

  Data({this.storeDetails, this.latestProducts});

  Data.fromJson(Map<String, dynamic> json) {
    storeDetails = json['storeDetails'] != null
        ? new StoreDetails.fromJson(json['storeDetails'])
        : null;
    if (json['LatestProducts'] != null) {
      latestProducts = <LatestProducts>[];
      json['LatestProducts'].forEach((v) {
        latestProducts!.add(new LatestProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeDetails != null) {
      data['storeDetails'] = this.storeDetails!.toJson();
    }
    if (this.latestProducts != null) {
      data['LatestProducts'] =
          this.latestProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreDetails {
  dynamic id;
  dynamic userId;
  dynamic storeName;
  dynamic phone;
  bool? importedMeat;
  bool? importedChicken;
  dynamic storeImage;
  dynamic distance;
  dynamic availability;

  StoreDetails(
      {this.id,
        this.userId,
        this.storeName,
        this.phone,
        this.importedMeat,
        this.importedChicken,
        this.storeImage,
        this.distance,
        this.availability});

  StoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeName = json['store_name'];
    phone = json['phone'];
    importedMeat = json['imported_meat'];
    importedChicken = json['imported_chicken'];
    storeImage = json['store_image'];
    distance = json['distance'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_name'] = this.storeName;
    data['phone'] = this.phone;
    data['imported_meat'] = this.importedMeat;
    data['imported_chicken'] = this.importedChicken;
    data['store_image'] = this.storeImage;
    data['distance'] = this.distance;
    data['availability'] = this.availability;
    return data;
  }
}

class LatestProducts {
  dynamic id;
  dynamic name;
  dynamic sKU;
  dynamic type;
  dynamic content;
  dynamic image;
  bool? status;
  //List<Variants>? variants;
  RxString varientIndex = "".obs;
  List<Variants>? variants=[];
  List<Addons>? addons;

  LatestProducts(
      {this.id,
        this.name,
        this.sKU,
        this.type,
        this.content,
        this.image,
        this.status,
        this.variants,
        this.addons});

  LatestProducts.fromJson(Map<String, dynamic> json) {
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
  dynamic name;
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

class Meta {
  dynamic totalPage;
  dynamic currentPage;
  dynamic totalItem;
  dynamic perPage;

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

