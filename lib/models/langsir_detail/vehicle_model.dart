class VehicleModel {
  final String? id;
  final String? policeNumber;
  final int? capacity;
  final int? productionYear;

  VehicleModel({
    this.id,
    this.policeNumber,
    this.capacity,
    this.productionYear,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      policeNumber: json['police_number'],
      capacity: json['capacity'],
      productionYear: json['production_year'],
    );
  }
}
