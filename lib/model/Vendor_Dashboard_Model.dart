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
  dynamic grossSales;
  dynamic grossSalesPercent;
  dynamic earning;
  dynamic earningPercent;
  dynamic soldItems;
  dynamic soldItemsPercent;
  dynamic orderReceived;
  dynamic orderReceivedPercent;
  dynamic startTime;
  dynamic endTime;
  bool? store;
  bool? selfDelivery;
  List<OrderList>? orderList;

  Data(
      {this.grossSales,
      this.grossSalesPercent,
      this.earning,
      this.earningPercent,
      this.soldItems,
      this.soldItemsPercent,
      this.orderReceived,
      this.orderReceivedPercent,
      this.startTime,
      this.endTime,
      this.store,
      this.selfDelivery,
      this.orderList});

  Data.fromJson(Map<String, dynamic> json) {
    grossSales = json['gross_sales'];
    grossSalesPercent = json['gross_sales_percent'];
    earning = json['earning'];
    earningPercent = json['earning_percent'];
    soldItems = json['sold_items'];
    soldItemsPercent = json['sold_items_percent'];
    orderReceived = json['order_received'];
    orderReceivedPercent = json['order_received_percent'];
    startTime = json['start_time'];
    endTime = json['end_time'];
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
    data['gross_sales'] = this.grossSales;
    data['gross_sales_percent'] = this.grossSalesPercent;
    data['earning'] = this.earning;
    data['earning_percent'] = this.earningPercent;
    data['sold_items'] = this.soldItems;
    data['sold_items_percent'] = this.soldItemsPercent;
    data['order_received'] = this.orderReceived;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
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
  String? amount;
  String? date;
  String? status;

  OrderList({this.id, this.amount, this.date, this.status});

  OrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
