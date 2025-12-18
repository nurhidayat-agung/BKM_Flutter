class PksModel {
  final String? id;
  final String? name;
  final String? code;

  PksModel({this.id, this.name, this.code});

  factory PksModel.fromJson(Map<String, dynamic> json) {
    return PksModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}

class DestinationModel {
  final String? id;
  final String? name;
  final String? code;

  DestinationModel({this.id, this.name, this.code});

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}

class CommodityModel {
  final String? id;
  final String? name;
  final String? code;

  CommodityModel({this.id, this.name, this.code});

  factory CommodityModel.fromJson(Map<String, dynamic> json) {
    return CommodityModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}

class BillingModel {
  final String? id;
  final String? name;
  final String? code;

  BillingModel({this.id, this.name, this.code});

  factory BillingModel.fromJson(Map<String, dynamic> json) {
    return BillingModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}
