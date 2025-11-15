import 'dart:convert';

DeliveryResponse deliveryResponseFromJson(String str) =>
    DeliveryResponse.fromJson(json.decode(str));

String deliveryResponseToJson(DeliveryResponse data) =>
    json.encode(data.toJson());

class DeliveryResponse {
  String? status;
  List<DeliveryData>? data;

  DeliveryResponse({
    this.status,
    this.data,
  });

  factory DeliveryResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DeliveryData>.from(
                json["data"].map((x) => DeliveryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DeliveryData {
  String? id;
  String? doId;
  String? vehicleId;
  String? driverId;
  String? linkedDetailId;
  int? doNumber;
  int? loadQuantity;
  int? unloadQuantity;
  String? loadDate;
  String? unloadDate;
  String? status;
  String? latestStatusLog;
  String? spbNumber;
  int? shippingCost;
  String? note;
  int? isIssued;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  NextStep? nextStep;
  DeliveryOrder? deliveryOrder;
  Driver? driver;
  Vehicle? vehicle;
  LinkedDetail? linkedDetail;
  List<AppLog>? appLogs;

  DeliveryData({
    this.id,
    this.doId,
    this.vehicleId,
    this.driverId,
    this.linkedDetailId,
    this.doNumber,
    this.loadQuantity,
    this.unloadQuantity,
    this.loadDate,
    this.unloadDate,
    this.status,
    this.latestStatusLog,
    this.spbNumber,
    this.shippingCost,
    this.note,
    this.isIssued,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.nextStep,
    this.deliveryOrder,
    this.driver,
    this.vehicle,
    this.linkedDetail,
    this.appLogs,
  });

  factory DeliveryData.fromJson(Map<String, dynamic> json) => DeliveryData(
        id: json["id"],
        doId: json["do_id"],
        vehicleId: json["vehicle_id"],
        driverId: json["driver_id"],
        linkedDetailId: json["linked_detail_id"],
        doNumber: json["do_number"],
        loadQuantity: json["load_quantity"],
        unloadQuantity: json["unload_quantity"],
        loadDate: json["load_date"],
        unloadDate: json["unload_date"],
        status: json["status"],
        latestStatusLog: json["latest_status_log"],
        spbNumber: json["spb_number"],
        shippingCost: json["shipping_cost"],
        note: json["note"],
        isIssued: json["is_issued"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        nextStep:
            json["nextStep"] == null ? null : NextStep.fromJson(json["nextStep"]),
        deliveryOrder: json["delivery_order"] == null
            ? null
            : DeliveryOrder.fromJson(json["delivery_order"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        linkedDetail: json["linked_detail"] == null
            ? null
            : LinkedDetail.fromJson(json["linked_detail"]),
        appLogs: json["app_logs"] == null
            ? []
            : List<AppLog>.from(
                json["app_logs"].map((x) => AppLog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "do_id": doId,
        "vehicle_id": vehicleId,
        "driver_id": driverId,
        "linked_detail_id": linkedDetailId,
        "do_number": doNumber,
        "load_quantity": loadQuantity,
        "unload_quantity": unloadQuantity,
        "load_date": loadDate,
        "unload_date": unloadDate,
        "status": status,
        "latest_status_log": latestStatusLog,
        "spb_number": spbNumber,
        "shipping_cost": shippingCost,
        "note": note,
        "is_issued": isIssued,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "nextStep": nextStep?.toJson(),
        "delivery_order": deliveryOrder?.toJson(),
        "driver": driver?.toJson(),
        "vehicle": vehicle?.toJson(),
        "linked_detail": linkedDetail?.toJson(),
        "app_logs": appLogs == null
            ? []
            : List<dynamic>.from(appLogs!.map((x) => x.toJson())),
      };
}

class NextStep {
  String? id;
  String? name;
  String? code;
  String? fieldValue;
  int? sort;

  NextStep({
    this.id,
    this.name,
    this.code,
    this.fieldValue,
    this.sort,
  });

  factory NextStep.fromJson(Map<String, dynamic> json) => NextStep(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        fieldValue: json["field_value"],
        sort: json["sort"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "field_value": fieldValue,
        "sort": sort,
      };
}

class DeliveryOrder {
  String? id;
  String? doNumber;
  String? doDate;
  int? quantity;
  int? remainingQty;
  int? qualityClaim;
  int? commodityPrice;
  String? status;

  DeliveryOrder({
    this.id,
    this.doNumber,
    this.doDate,
    this.quantity,
    this.remainingQty,
    this.qualityClaim,
    this.commodityPrice,
    this.status,
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) => DeliveryOrder(
        id: json["id"],
        doNumber: json["do_number"],
        doDate: json["do_date"],
        quantity: json["quantity"],
        remainingQty: json["remaining_qty"],
        qualityClaim: json["quality_claim"],
        commodityPrice: json["commodity_price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "do_number": doNumber,
        "do_date": doDate,
        "quantity": quantity,
        "remaining_qty": remainingQty,
        "quality_claim": qualityClaim,
        "commodity_price": commodityPrice,
        "status": status,
      };
}

class Driver {
  String? id;
  String? name;
  String? code;
  String? simNumber;
  String? simType;
  String? phoneNumber;
  String? address;

  Driver({
    this.id,
    this.name,
    this.code,
    this.simNumber,
    this.simType,
    this.phoneNumber,
    this.address,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        simNumber: json["sim_number"],
        simType: json["sim_type"],
        phoneNumber: json["phone_number"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "sim_number": simNumber,
        "sim_type": simType,
        "phone_number": phoneNumber,
        "address": address,
      };
}

class Vehicle {
  String? id;
  String? policeNumber;
  int? capacity;
  int? productionYear;

  Vehicle({
    this.id,
    this.policeNumber,
    this.capacity,
    this.productionYear,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        policeNumber: json["police_number"],
        capacity: json["capacity"],
        productionYear: json["production_year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "police_number": policeNumber,
        "capacity": capacity,
        "production_year": productionYear,
      };
}

class LinkedDetail {
  String? id;
  int? doNumber;
  int? loadQuantity;
  int? unloadQuantity;
  String? loadDate;
  String? unloadDate;
  String? status;
  DeliveryOrder? deliveryOrder;

  LinkedDetail({
    this.id,
    this.doNumber,
    this.loadQuantity,
    this.unloadQuantity,
    this.loadDate,
    this.unloadDate,
    this.status,
    this.deliveryOrder,
  });

  factory LinkedDetail.fromJson(Map<String, dynamic> json) => LinkedDetail(
        id: json["id"],
        doNumber: json["do_number"],
        loadQuantity: json["load_quantity"],
        unloadQuantity: json["unload_quantity"],
        loadDate: json["load_date"],
        unloadDate: json["unload_date"],
        status: json["status"],
        deliveryOrder: json["delivery_order"] == null
            ? null
            : DeliveryOrder.fromJson(json["delivery_order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "do_number": doNumber,
        "load_quantity": loadQuantity,
        "unload_quantity": unloadQuantity,
        "load_date": loadDate,
        "unload_date": unloadDate,
        "status": status,
        "delivery_order": deliveryOrder?.toJson(),
      };
}

class AppLog {
  String? id;
  String? note;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppLog({
    this.id,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AppLog.fromJson(Map<String, dynamic> json) => AppLog(
        id: json["id"],
        note: json["note"],
        status: json["status"] == null 
            ? null 
            : Status.fromJson(json["status"]),
        
        // aman dari null, aman dari parse error
        createdAt: json["created_at"] != null && json["created_at"] != ""
            ? DateTime.tryParse(json["created_at"])
            : null,

        updatedAt: json["updated_at"] != null && json["updated_at"] != ""
            ? DateTime.tryParse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "note": note,
        "status": status?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}


class Status {
  String? id;
  String? name;
  String? code;
  String? fieldValue;
  int? sort;

  Status({
    this.id,
    this.name,
    this.code,
    this.fieldValue,
    this.sort
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        fieldValue: json["field_value"],
        sort: json["sort"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "field_value": fieldValue,
        "sort" : sort
      };
}
