class VehicleData {
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

  VehicleData({
    this.id,
    this.siteId,
    this.typeVehicleId,
    this.fuelTypeId,
    this.pic,
    this.status,
    this.policeNumber,
    this.stnkNumber,
    this.stnkExpiration,
    this.taxExpiration,
    this.kirExpiration,
    this.chassisNumber,
    this.machineNumber,
    this.capacity,
    this.estimatedLoad,
    this.productionYear,
    this.terminal,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
    id: json["id"],
    siteId: json["site_id"],
    typeVehicleId: json["type_vehicle_id"],
    fuelTypeId: json["fuel_type_id"],
    pic: json["pic"],
    status: json["status"],
    policeNumber: json["police_number"],
    stnkNumber: json["stnk_number"],
    stnkExpiration: json["stnk_expiration"],
    taxExpiration: json["tax_expiration"],
    kirExpiration: json["kir_expiration"],
    chassisNumber: json["chassis_number"],
    machineNumber: json["machine_number"],
    capacity: json["capacity"],
    estimatedLoad: json["estimated_load"],
    productionYear: json["production_year"],
    terminal: json["terminal"],
    description: json["description"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}