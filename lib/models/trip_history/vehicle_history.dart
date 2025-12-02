class VehicleHistory {
  String? id;
  String? siteId;
  String? typeVehicleId;
  String? fuelTypeId;
  String? pic;
  String? status;
  String? policeNumber;
  String? stnkNumber;
  String? stnkExpiration;
  String? taxExpiration;
  String? kirExpiration;
  String? chassisNumber;
  String? machineNumber;
  int? capacity;
  int? estimatedLoad;
  int? productionYear;
  String? terminal;
  String? description;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  VehicleHistory();

  factory VehicleHistory.fromJson(Map<String, dynamic> json) => VehicleHistory()
    ..id = json['id']
    ..siteId = json['site_id']
    ..typeVehicleId = json['type_vehicle_id']
    ..fuelTypeId = json['fuel_type_id']
    ..pic = json['pic']
    ..status = json['status']
    ..policeNumber = json['police_number']
    ..stnkNumber = json['stnk_number']
    ..stnkExpiration = json['stnk_expiration']
    ..taxExpiration = json['tax_expiration']
    ..kirExpiration = json['kir_expiration']
    ..chassisNumber = json['chassis_number']
    ..machineNumber = json['machine_number']
    ..capacity = json['capacity']
    ..estimatedLoad = json['estimated_load']
    ..productionYear = json['production_year']
    ..terminal = json['terminal']
    ..description = json['description']
    ..isActive = json['is_active']
    ..createdBy = json['created_by']
    ..updatedBy = json['updated_by']
    ..deletedBy = json['deleted_by']
    ..deletedAt = json['deleted_at']
    ..createdAt = json['created_at']
    ..updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "site_id": siteId,
      "type_vehicle_id": typeVehicleId,
      "fuel_type_id": fuelTypeId,
      "pic": pic,
      "status": status,
      "police_number": policeNumber,
      "stnk_number": stnkNumber,
      "stnk_expiration": stnkExpiration,
      "tax_expiration": taxExpiration,
      "kir_expiration": kirExpiration,
      "chassis_number": chassisNumber,
      "machine_number": machineNumber,
      "capacity": capacity,
      "estimated_load": estimatedLoad,
      "production_year": productionYear,
      "terminal": terminal,
      "description": description,
      "is_active": isActive,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "deleted_by": deletedBy,
      "deleted_at": deletedAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }

}
