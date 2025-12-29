class ReplacementPartHistoryResp {
  int? status;
  String? message;
  List<DataReplacementPartHistory>? data;

  ReplacementPartHistoryResp({this.status, this.message, this.data});

  ReplacementPartHistoryResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataReplacementPartHistory>[];
      json['data'].forEach((v) {
        data!.add(new DataReplacementPartHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataReplacementPartHistory {
  String? transactionId;
  String? transactionCode;
  String? brandName;
  String? itemName;
  String? itemCode;
  String? transactionDate;
  String? requestBy;
  String? days;

  DataReplacementPartHistory(
      {this.transactionId,
        this.transactionCode,
        this.brandName,
        this.itemName,
        this.itemCode,
        this.transactionDate,
        this.requestBy,
        this.days});

  DataReplacementPartHistory.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    transactionCode = json['transaction_code'];
    brandName = json['brand_name'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    transactionDate = json['transaction_date'];
    requestBy = json['request_by'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['transaction_code'] = this.transactionCode;
    data['brand_name'] = this.brandName;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['transaction_date'] = this.transactionDate;
    data['request_by'] = this.requestBy;
    data['days'] = this.days;
    return data;
  }
}