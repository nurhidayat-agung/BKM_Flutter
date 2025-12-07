class DriverHistory {
  final String? id;
  final String? siteId;
  final String? userId;
  final String? name;
  final String? alias;
  final String? code;
  final String? status;
  final String? placeOfBirth;
  final String? simNumber;
  final String? simType;
  final String? phoneNumber;
  final String? address;

  DriverHistory({
    this.id,
    this.siteId,
    this.userId,
    this.name,
    this.alias,
    this.code,
    this.status,
    this.placeOfBirth,
    this.simNumber,
    this.simType,
    this.phoneNumber,
    this.address,
  });

  factory DriverHistory.fromJson(Map<String, dynamic> json) {
    return DriverHistory(
      id: json['id'],
      siteId: json['site_id'],
      userId: json['user_id'],
      name: json['name'],
      alias: json['alias'],
      code: json['code'],
      status: json['status'],
      placeOfBirth: json['place_of_birth'],
      simNumber: json['sim_number'],
      simType: json['sim_type'],
      phoneNumber: json['phone_number'],
      address: json['address'],
    );
  }
}
