class QueueResp {
  int? status;
  String? message;
  List<DataQueue>? data;

  QueueResp({this.status, this.message, this.data});

  QueueResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataQueue>[];
      json['data'].forEach((v) {
        data!.add(new DataQueue.fromJson(v));
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

class DataQueue {
  String? id;
  String? code;
  String? registerAt;
  String? queueNumber;
  String? message;
  String? seq;
  int? queueTo;
  String? status;

  DataQueue(
      {this.id,
        this.code,
        this.registerAt,
        this.queueNumber,
        this.message,
        this.seq,
        this.queueTo,
        this.status});

  DataQueue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    registerAt = json['register_at'];
    queueNumber = json['queue_number'];
    message = json['message'];
    seq = json['seq'];
    queueTo = json['queue_to'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['register_at'] = this.registerAt;
    data['queue_number'] = this.queueNumber;
    data['message'] = this.message;
    data['seq'] = this.seq;
    data['queue_to'] = this.queueTo;
    data['status'] = this.status;
    return data;
  }
}