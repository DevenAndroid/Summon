// class MyWallletModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   MyWallletModel({this.status, this.message, this.data});
//
//   MyWallletModel.fromJson(Map<String, dynamic> json) {
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
//  dynamic totalAmount;
//  dynamic withdrawalbleAmount;
//  dynamic unutilisedAmount;
//   List<WalletTransactions>? walletTransactions;
//
//   Data(
//       {this.totalAmount,
//       this.withdrawalbleAmount,
//       this.unutilisedAmount,
//       this.walletTransactions});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     totalAmount = json['totalAmount'];
//     withdrawalbleAmount = json['withdrawalbleAmount'];
//     unutilisedAmount = json['unutilisedAmount'];
//     if (json['walletTransactions'] != null) {
//       walletTransactions = <WalletTransactions>[];
//       json['walletTransactions'].forEach((v) {
//         walletTransactions!.add(new WalletTransactions.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['totalAmount'] = this.totalAmount;
//     data['withdrawalbleAmount'] = this.withdrawalbleAmount;
//     data['unutilisedAmount'] = this.unutilisedAmount;
//     if (this.walletTransactions != null) {
//       data['walletTransactions'] =
//           this.walletTransactions!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class WalletTransactions {
//   dynamic id;
//   dynamic userId;
//   dynamic previousBalance;
//   dynamic currentBalance;
//   dynamic amount;
//   dynamic status;
//   dynamic remark;
//   dynamic transactionDate;
//
//   WalletTransactions(
//       {this.id,
//       this.userId,
//       this.previousBalance,
//       this.currentBalance,
//       this.amount,
//       this.status,
//       this.remark,
//       this.transactionDate});
//
//   WalletTransactions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     previousBalance = json['previous_balance'];
//     currentBalance = json['current_balance'];
//     amount = json['amount'];
//     status = json['status'];
//     remark = json['remark'];
//     transactionDate = json['transaction_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['previous_balance'] = this.previousBalance;
//     data['current_balance'] = this.currentBalance;
//     data['amount'] = this.amount;
//     data['status'] = this.status;
//     data['remark'] = this.remark;
//     data['transaction_date'] = this.transactionDate;
//     return data;
//   }
// }
class MyWalletModel {
  bool? status;
  String? message;
  Data? data;
  Meta? meta;
  Link? link;

  MyWalletModel({this.status, this.message, this.data, this.meta, this.link});

  MyWalletModel.fromJson(Map<String, dynamic> json) {
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
 dynamic totalAmount;
 dynamic withdrawalbleAmount;
 dynamic unutilisedAmount;
  List<WalletTransactions>? walletTransactions;

  Data(
      {this.totalAmount,
        this.withdrawalbleAmount,
        this.unutilisedAmount,
        this.walletTransactions});

  Data.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    withdrawalbleAmount = json['withdrawalbleAmount'];
    unutilisedAmount = json['unutilisedAmount'];
    if (json['walletTransactions'] != null) {
      walletTransactions = <WalletTransactions>[];
      json['walletTransactions'].forEach((v) {
        walletTransactions!.add(new WalletTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    data['withdrawalbleAmount'] = this.withdrawalbleAmount;
    data['unutilisedAmount'] = this.unutilisedAmount;
    if (this.walletTransactions != null) {
      data['walletTransactions'] =
          this.walletTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactions {
  dynamic id;
  dynamic userId;
  dynamic previousBalance;
  dynamic currentBalance;
  dynamic amount;
  dynamic status;
  dynamic remark;
  dynamic transactionDate;

  WalletTransactions(
      {this.id,
        this.userId,
        this.previousBalance,
        this.currentBalance,
        this.amount,
        this.status,
        this.remark,
        this.transactionDate});

  WalletTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    previousBalance = json['previous_balance'];
    currentBalance = json['current_balance'];
    amount = json['amount'];
    status = json['status'];
    remark = json['remark'];
    transactionDate = json['transaction_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['previous_balance'] = this.previousBalance;
    data['current_balance'] = this.currentBalance;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['transaction_date'] = this.transactionDate;
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
