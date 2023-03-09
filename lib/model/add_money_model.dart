class AddMoneyModel {
  bool? status;
  String? message;
  Data? data;

  AddMoneyModel({this.status, this.message, this.data});

  AddMoneyModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? previousBalance;
  int? currentBalance;
  String? amount;
  String? status;
  String? remark;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
        this.previousBalance,
        this.currentBalance,
        this.amount,
        this.status,
        this.remark,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    previousBalance = json['previous_balance'];
    currentBalance = json['current_balance'];
    amount = json['amount'];
    status = json['status'];
    remark = json['remark'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['previous_balance'] = this.previousBalance;
    data['current_balance'] = this.currentBalance;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
