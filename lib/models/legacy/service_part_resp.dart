class ServicePartResp {
  int? status;
  String? message;
  List<DataServicePart>? data;

  ServicePartResp({this.status, this.message, this.data});

  ServicePartResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataServicePart>[];
      json['data'].forEach((v) {
        data!.add(new DataServicePart.fromJson(v));
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

class DataServicePart {
  String? id;
  String? brandId;
  String? unitId;
  String? itemCode;
  String? itemName;
  String? price;

  DataServicePart(
      {this.id,
        this.brandId,
        this.unitId,
        this.itemCode,
        this.itemName,
        this.price});

  DataServicePart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    unitId = json['unit_id'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_id'] = this.brandId;
    data['unit_id'] = this.unitId;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['price'] = this.price;
    return data;
  }
}