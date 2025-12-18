class DriverModel {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? simNumber;

  DriverModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.simNumber,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      simNumber: json['sim_number'],
    );
  }
}
