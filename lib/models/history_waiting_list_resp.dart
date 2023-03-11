import 'dart:ui';

class HistoryWaitingListResp {
  int? status;
  String? message;
  List<DataHistoryWaitingList>? data;

  HistoryWaitingListResp({this.status, this.message, this.data});

  HistoryWaitingListResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataHistoryWaitingList>[];
      json['data'].forEach((v) {
        data!.add(new DataHistoryWaitingList.fromJson(v));
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

class DataHistoryWaitingList {
  String? reason;
  String? driverId;
  String? code;
  String? checkin;
  String? checkout;
  String? registerAt;
  String? description;
  String? id;
  String? vehicleId;
  String? seq;
  String? status;
  String? statusDesc;
  String? sparepartTrxCode;
  WLListitemDriver? driver;
  WLListItemVehicle? vehicle;
  Color? statusColor;

  DataHistoryWaitingList(
      {this.reason,
        this.driverId,
        this.code,
        this.checkin,
        this.checkout,
        this.registerAt,
        this.description,
        this.id,
        this.vehicleId,
        this.seq,
        this.status,
        this.statusDesc,
        this.sparepartTrxCode,
        this.driver,
        this.vehicle,
        this.statusColor});

  DataHistoryWaitingList.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    driverId = json['driver_id'];
    code = json['code'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    registerAt = json['register_at'];
    description = json['description'];
    id = json['id'];
    vehicleId = json['vehicle_id'];
    seq = json['seq'];
    status = json['status'];
    statusDesc = json['status_desc'];
    sparepartTrxCode = json['sparepart_trx_code'];
    driver =
    json['driver'] != null ? WLListitemDriver.fromJson(json['driver']) : null;
    vehicle =
    json['vehicle'] != null ? WLListItemVehicle.fromJson(json['vehicle']) : null;
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
    data['reason'] = this.reason;
    data['driver_id'] = this.driverId;
    data['code'] = this.code;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['register_at'] = this.registerAt;
    data['description'] = this.description;
    data['id'] = this.id;
    data['vehicle_id'] = this.vehicleId;
    data['seq'] = this.seq;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    data['sparepart_trx_code'] = this.sparepartTrxCode;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    return data;
  }
}

class WLListitemDriver {
  String? id;
  String? driverName;

  WLListitemDriver({this.id, this.driverName});

  WLListitemDriver.fromJson(Map<String, dynamic> json) {
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

class WLListItemVehicle {
  String? id;
  String? vehicleNumber;

  WLListItemVehicle({this.id, this.vehicleNumber});

  WLListItemVehicle.fromJson(Map<String, dynamic> json) {
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