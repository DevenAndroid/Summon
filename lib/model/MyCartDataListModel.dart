// class MyCartDataModel1 {
//   List<Data>? data;
//
//   MyCartDataModel1({this.data});
//
//   MyCartDataModel1.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? productId;
//   int? variantId;
//   String? name;
//   String? sizeId;
//   String? size;
//   int? minQty;
//   int? maxQty;
//   String? variantPrice;
//   int? cartItemQty;
//   List<Null>? addons;
//   int? totalPrice;
//   String? image;
//   String? note;
//
//   Data(
//       {this.id,
//         this.productId,
//         this.variantId,
//         this.name,
//         this.sizeId,
//         this.size,
//         this.minQty,
//         this.maxQty,
//         this.variantPrice,
//         this.cartItemQty,
//         this.addons,
//         this.totalPrice,
//         this.image,
//         this.note});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     variantId = json['variant_id'];
//     name = json['name'];
//     sizeId = json['size_id'];
//     size = json['size'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     variantPrice = json['variant_price'];
//     cartItemQty = json['cart_item_qty'];
//     if (json['addons'] != null) {
//       addons = <Null>[];
//       json['addons'].forEach((v) {
//         addons!.add(new Null.fromJson(v));
//       });
//     }
//     totalPrice = json['total_price'];
//     image = json['image'];
//     note = json['note'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['variant_id'] = this.variantId;
//     data['name'] = this.name;
//     data['size_id'] = this.sizeId;
//     data['size'] = this.size;
//     data['min_qty'] = this.minQty;
//     data['max_qty'] = this.maxQty;
//     data['variant_price'] = this.variantPrice;
//     data['cart_item_qty'] = this.cartItemQty;
//     if (this.addons != null) {
//       data['addons'] = this.addons!.map((v) => v.toJson()).toList();
//     }
//     data['total_price'] = this.totalPrice;
//     data['image'] = this.image;
//     data['note'] = this.note;
//     return data;
//   }
// }
