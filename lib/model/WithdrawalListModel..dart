class WithdrawalListModel {
  bool? status;
  String? message;
  Data? data;

  WithdrawalListModel({this.status, this.message, this.data});

  WithdrawalListModel.fromJson(Map<String, dynamic> json) {
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
  List<WithdrawalList>? withdrawalList;

  Data({this.earnedBalance, this.withdrawalList});

  Data.fromJson(Map<String, dynamic> json) {
    earnedBalance = json['earnedBalance'];
    if (json['withdrawalList'] != null) {
      withdrawalList = <WithdrawalList>[];
      json['withdrawalList'].forEach((v) {
        withdrawalList!.add(new WithdrawalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['earnedBalance'] = this.earnedBalance;
    if (this.withdrawalList != null) {
      data['withdrawalList'] =
          this.withdrawalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WithdrawalList {
  int? id;
  String? amount;
  String? date;
  String? status;

  WithdrawalList({this.id, this.amount, this.date, this.status});

  WithdrawalList.fromJson(Map<String, dynamic> json) {
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
