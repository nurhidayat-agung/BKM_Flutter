class ServiceBookResp {
  int? status;
  String? message;
  List<DataServiceBook>? data;

  ServiceBookResp({this.status, this.message, this.data});

  ServiceBookResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataServiceBook>[];
      json['data'].forEach((v) {
        data!.add(new DataServiceBook.fromJson(v));
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

class DataServiceBook {
  String? id;
  String? vehicleId;
  String? serviceDate;
  String? km;
  String? actualKm;
  String? description;

  DataServiceBook(
      {this.id,
        this.vehicleId,
        this.serviceDate,
        this.km,
        this.actualKm,
        this.description});

  DataServiceBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleId = json['vehicle_id'];
    serviceDate = json['service_date'];
    km = json['km'];
    actualKm = json['actual_km'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_id'] = this.vehicleId;
    data['service_date'] = this.serviceDate;
    data['km'] = this.km;
    data['actual_km'] = this.actualKm;
    data['description'] = this.description;
    return data;
  }
}

