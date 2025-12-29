class RegisterWorkshopResp {
  int? status;
  String? message;
  List<DataRegisterWorkshop>? data;

  RegisterWorkshopResp({this.status, this.message, this.data});

  RegisterWorkshopResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataRegisterWorkshop>[];
      json['data'].forEach((v) {
        data!.add(new DataRegisterWorkshop.fromJson(v));
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

class DataRegisterWorkshop {
  String? reason;
  String? driverId;
  String? code;
  String? ciSession;
  String? registerAt;
  String? queueNumber;
  String? id;
  String? vehicleId;
  int? seq;
  int? queueTo;
  String? status;

  DataRegisterWorkshop(
      {this.reason,
        this.driverId,
        this.code,
        this.ciSession,
        this.registerAt,
        this.queueNumber,
        this.id,
        this.vehicleId,
        this.seq,
        this.queueTo,
        this.status});

  DataRegisterWorkshop.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    driverId = json['driver_id'];
    code = json['code'];
    ciSession = json['ci_session_'];
    registerAt = json['register_at'];
    queueNumber = json['queue_number'];
    id = json['id'];
    vehicleId = json['vehicle_id'];
    seq = json['seq'];
    queueTo = json['queue_to'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['driver_id'] = this.driverId;
    data['code'] = this.code;
    data['ci_session_'] = this.ciSession;
    data['register_at'] = this.registerAt;
    data['queue_number'] = this.queueNumber;
    data['id'] = this.id;
    data['vehicle_id'] = this.vehicleId;
    data['seq'] = this.seq;
    data['queue_to'] = this.queueTo;
    data['status'] = this.status;
    return data;
  }
}