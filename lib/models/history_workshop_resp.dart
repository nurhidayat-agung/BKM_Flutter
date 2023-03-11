import 'dart:ui';

class HistoryWorkshopResp {
  int? status;
  String? message;
  List<DataHistoryWorkshop>? data;

  HistoryWorkshopResp({this.status, this.message, this.data});

  HistoryWorkshopResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataHistoryWorkshop>[];
      json['data'].forEach((v) {
        data!.add(new DataHistoryWorkshop.fromJson(v));
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

class DataHistoryWorkshop {
  String? id;
  String? seq;
  String? code;
  String? registerAt;
  String? checkin;
  String? checkout;
  String? status;
  String? sparepartTrxCode;
  String? reason;
  String? description;
  String? statusDesc;
  Driver? driver;
  Vehicle? vehicle;
  List<ItemSparePartWorkshop>? listSparepart;
  Color? statusColor;

  DataHistoryWorkshop(
      {this.id,
        this.seq,
        this.code,
        this.registerAt,
        this.checkin,
        this.checkout,
        this.status,
        this.sparepartTrxCode,
        this.reason,
        this.description,
        this.statusDesc,
        this.driver,
        this.vehicle,
        this.listSparepart,
        this.statusColor});

  DataHistoryWorkshop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seq = json['seq'];
    code = json['code'];
    registerAt = json['register_at'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    status = json['status'];
    sparepartTrxCode = json['sparepart_trx_code'];
    reason = json['reason'];
    description = json['description'];
    statusDesc = json['status_desc'];
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    vehicle =
    json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    if (json['list_sparepart'] != null) {
      listSparepart = <ItemSparePartWorkshop>[];
      json['list_sparepart'].forEach((v) {
        listSparepart!.add(new ItemSparePartWorkshop.fromJson(v));
      });
    }
    if (status?.toLowerCase() == "p") {
      statusColor = const Color(0xff336699);
    }
    else if (status?.toLowerCase() == "w") {
      statusColor = const Color(0xffed9111);
    }
    else if (status?.toLowerCase() == "c") {
      statusColor = const Color(0xff424242);
    }
    else {
      statusColor = const Color(0xff29d6d9);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['code'] = this.code;
    data['register_at'] = this.registerAt;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['status'] = this.status;
    data['sparepart_trx_code'] = this.sparepartTrxCode;
    data['reason'] = this.reason;
    data['description'] = this.description;
    data['status_desc'] = this.statusDesc;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    if (this.listSparepart != null) {
      data['list_sparepart'] =
          this.listSparepart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Driver {
  String? id;
  String? driverName;

  Driver({this.id, this.driverName});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverName = json['driver_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_name'] = this.driverName;
    return data;
  }
}

class Vehicle {
  String? id;
  String? vehicleNumber;

  Vehicle({this.id, this.vehicleNumber});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleNumber = json['vehicle_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_number'] = this.vehicleNumber;
    return data;
  }
}

class ItemSparePartWorkshop {
  String? unitName;
  String? transactionCode;
  String? qty;
  String? itemName;

  ItemSparePartWorkshop(
      {this.unitName,
        this.transactionCode,
        this.qty,
        this.itemName});

  ItemSparePartWorkshop.fromJson(Map<String, dynamic> json) {
    unitName = json['unit_name'];
    transactionCode = json['transaction_code'];
    qty = json['qty'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit_name'] = this.unitName;
    data['transaction_code'] = this.transactionCode;
    data['qty'] = this.qty;
    data['item_name'] = this.itemName;
    return data;
  }
}