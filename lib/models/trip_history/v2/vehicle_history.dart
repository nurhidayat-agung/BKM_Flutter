class VehicleHistory {
  final String? id;
  final String? siteId;
  final String? typeVehicleId;
  final String? fuelTypeId;
  final String? pic;
  final String? status;
  final String? policeNumber;
  final String? stnkNumber;
  final int? capacity;

  VehicleHistory({
    this.id,
    this.siteId,
    this.typeVehicleId,
    this.fuelTypeId,
    this.pic,
    this.status,
    this.policeNumber,
    this.stnkNumber,
    this.capacity,
  });

  factory VehicleHistory.fromJson(Map<String, dynamic> json) {
    return VehicleHistory(
      id: json['id'],
      siteId: json['site_id'],
      typeVehicleId: json['type_vehicle_id'],
      fuelTypeId: json['fuel_type_id'],
      pic: json['pic'],
      status: json['status'],
      policeNumber: json['police_number'],
      stnkNumber: json['stnk_number'],
      capacity: json['capacity'],
    );
  }
}
