class LinkedDetailHistory {
  final String? id;
  final String? doId;
  final String? vehicleId;
  final String? driverId;
  final int? doNumber;
  final num? loadQuantity;

  LinkedDetailHistory({
    this.id,
    this.doId,
    this.vehicleId,
    this.driverId,
    this.doNumber,
    this.loadQuantity,
  });

  factory LinkedDetailHistory.fromJson(Map<String, dynamic> json) {
    return LinkedDetailHistory(
      id: json['id'],
      doId: json['do_id'],
      vehicleId: json['vehicle_id'],
      driverId: json['driver_id'],
      doNumber: json['do_number'],
      loadQuantity: json['load_quantity'],
    );
  }
}
