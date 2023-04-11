import 'package:get/get.dart';

// class StoreDetailsModel {
//   bool? status;
//   String? message;
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
//   int? id;
//   String? storeName;
//   String? storeImage;
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
//   int? id;
//   String? name;
//   String? image;
//   List<Varints>? varints;
//   RxInt? varientIndex = (0).obs;
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
//   int? id;
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


class StoreDetailsModel {
  bool? status;
  String? message;
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
  List<LatestProducts>? latestProducts=[];

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
  int? id;
  dynamic storeName;
  dynamic storeImage;

  StoreDetails({this.id, this.storeName, this.storeImage});

  StoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    storeImage = json['store_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['store_image'] = this.storeImage;
    return data;
  }
}

class LatestProducts {
  int? id;
  dynamic name;
  dynamic image;
  RxInt? varientIndex = (0).obs;
  List<Varints>? varints;

  LatestProducts({this.id, this.name, this.image, this.varints});

  LatestProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['varints'] != null) {
      varints = <Varints>[];
      json['varints'].forEach((v) {
        varints!.add(new Varints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.varints != null) {
      data['varints'] = this.varints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Varints {
  dynamic id;
  dynamic vendorProductId;
  dynamic marketPrice;
  dynamic price;
  dynamic variantQty;
  dynamic variantQtyType;
  dynamic minQty;
  dynamic maxQty;
  dynamic discountOff;

  Varints(
      {this.id,
        this.vendorProductId,
        this.marketPrice,
        this.price,
        this.variantQty,
        this.variantQtyType,
        this.minQty,
        this.maxQty,
        this.discountOff});

  Varints.fromJson(Map<String, dynamic> json) {
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
