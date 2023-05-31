class VendorDashboardModel {
  bool? status;
  String? message;
  Data? data;

  VendorDashboardModel({this.status, this.message, this.data});

  VendorDashboardModel.fromJson(Map<String, dynamic> json) {
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
  dynamic startTime;
  dynamic endTime;
  int? storeStatus;
  dynamic username;
  dynamic grossSales;
  dynamic grossSalesPercent;
  dynamic earning;
  dynamic earningPercent;
  dynamic soldItems;
  dynamic soldItemsPercent;
  dynamic orderReceived;
  dynamic orderReceivedPercent;
  bool? store;
  bool? selfDelivery;
  List<OrderList>? orderList;

  Data(
      {this.startTime,
        this.endTime,
        this.storeStatus,
        this.username,
        this.grossSales,
        this.grossSalesPercent,
        this.earning,
        this.earningPercent,
        this.soldItems,
        this.soldItemsPercent,
        this.orderReceived,
        this.orderReceivedPercent,
        this.store,
        this.selfDelivery,
        this.orderList});

  Data.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    storeStatus = json['store_status'];
    username = json['username'];
    grossSales = json['gross_sales'];
    grossSalesPercent = json['gross_sales_percent'];
    earning = json['earning'];
    earningPercent = json['earning_percent'];
    soldItems = json['sold_items'];
    soldItemsPercent = json['sold_items_percent'];
    orderReceived = json['order_received'];
    orderReceivedPercent = json['order_received_percent'];
    store = json['store'];
    selfDelivery = json['self_delivery'];
    if (json['order_list'] != null) {
      orderList = <OrderList>[];
      json['order_list'].forEach((v) {
        orderList!.add(new OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['store_status'] = this.storeStatus;
    data['username'] = this.username;
    data['gross_sales'] = this.grossSales;
    data['gross_sales_percent'] = this.grossSalesPercent;
    data['earning'] = this.earning;
    data['earning_percent'] = this.earningPercent;
    data['sold_items'] = this.soldItems;
    data['sold_items_percent'] = this.soldItemsPercent;
    data['order_received'] = this.orderReceived;
    data['order_received_percent'] = this.orderReceivedPercent;
    data['store'] = this.store;
    data['self_delivery'] = this.selfDelivery;
    if (this.orderList != null) {
      data['order_list'] = this.orderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  int? id;
  String? name;
  List<OrderItem>? orderItem;
  String? amount;
  String? date;
  String? status;

  OrderList(
      {this.id,
        this.name,
        this.orderItem,
        this.amount,
        this.date,
        this.status});

  OrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['orderItem'] != null) {
      orderItem = <OrderItem>[];
      json['orderItem'].forEach((v) {
        orderItem!.add(new OrderItem.fromJson(v));
      });
    }
    amount = json['amount'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.orderItem != null) {
      data['orderItem'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}

class OrderItem {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic variantId;
  dynamic price;
  List<Addons>? addons;
  dynamic qty;
  dynamic totalPrice;
  String? note;
  String? status;

  OrderItem(
      {this.id,
        this.productId,
        this.productName,
        this.variantId,
        this.price,
        this.addons,
        this.qty,
        this.totalPrice,
        this.note,
        this.status});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    variantId = json['variant_id'];
    price = json['price'];
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
    qty = json['qty'];
    totalPrice = json['total_price'];
    note = json['note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['variant_id'] = this.variantId;
    data['price'] = this.price;
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    data['qty'] = this.qty;
    data['total_price'] = this.totalPrice;
    data['note'] = this.note;
    data['status'] = this.status;
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


// class VendorDashboardModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   VendorDashboardModel({this.status, this.message, this.data});
//
//   VendorDashboardModel.fromJson(Map<String, dynamic> json) {
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
//   dynamic grossSales;
//   dynamic grossSalesPercent;
//   dynamic earning;
//   dynamic earningPercent;
//   dynamic soldItems;
//   dynamic soldItemsPercent;
//   dynamic orderReceived;
//   dynamic orderReceivedPercent;
//   dynamic startTime;
//   dynamic endTime;
//   dynamic storeStatus;
//   bool? store;
//   bool? selfDelivery;
//   List<OrderList>? orderList;
//
//   Data(
//       {this.grossSales,
//       this.grossSalesPercent,
//       this.earning,
//       this.earningPercent,
//       this.soldItems,
//       this.soldItemsPercent,
//       this.orderReceived,
//       this.orderReceivedPercent,
//       this.startTime,
//       this.endTime,
//       this.storeStatus,
//       this.store,
//       this.selfDelivery,
//       this.orderList});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     grossSales = json['gross_sales'];
//     grossSalesPercent = json['gross_sales_percent'];
//     earning = json['earning'];
//     earningPercent = json['earning_percent'];
//     soldItems = json['sold_items'];
//     soldItemsPercent = json['sold_items_percent'];
//     orderReceived = json['order_received'];
//     orderReceivedPercent = json['order_received_percent'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//     orderReceivedPercent = json['order_received_percent'];
//     storeStatus = json['store_status'];
//     store = json['store'];
//     selfDelivery = json['self_delivery'];
//     if (json['order_list'] != null) {
//       orderList = <OrderList>[];
//       json['order_list'].forEach((v) {
//         orderList!.add(new OrderList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['gross_sales'] = this.grossSales;
//     data['gross_sales_percent'] = this.grossSalesPercent;
//     data['earning'] = this.earning;
//     data['earning_percent'] = this.earningPercent;
//     data['sold_items'] = this.soldItems;
//     data['sold_items_percent'] = this.soldItemsPercent;
//     data['order_received'] = this.orderReceived;
//     data['start_time'] = this.startTime;
//     data['end_time'] = this.endTime;
//     data['order_received_percent'] = this.orderReceivedPercent;
//     data['store_status'] = this.storeStatus;
//     data['store'] = this.store;
//     data['self_delivery'] = this.selfDelivery;
//     if (this.orderList != null) {
//       data['order_list'] = this.orderList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class OrderList {
//   int? id;
//   String? amount;
//   String? date;
//   String? status;
//
//   OrderList({this.id, this.amount, this.date, this.status});
//
//   OrderList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     amount = json['amount'];
//     date = json['date'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['amount'] = this.amount;
//     data['date'] = this.date;
//     data['status'] = this.status;
//     return data;
//   }
// }
