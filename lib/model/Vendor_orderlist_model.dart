class VendorOrderListModel {
  bool? status;
  String? message;
  Data? data;

  VendorOrderListModel({this.status, this.message, this.data});

  VendorOrderListModel.fromJson(Map<String, dynamic> json) {
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
  String? earnedBalance;
  List<OrderList>? orderList;

  Data({this.earnedBalance, this.orderList});

  Data.fromJson(Map<String, dynamic> json) {
    earnedBalance = json['earned_balance'];
    if (json['order_list'] != null) {
      orderList = <OrderList>[];
      json['order_list'].forEach((v) {
        orderList!.add(new OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['earned_balance'] = this.earnedBalance;
    if (this.orderList != null) {
      data['order_list'] = this.orderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  int? id;
  String? amount;
  String? status;

  OrderList({this.id, this.amount, this.status});

  OrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}
