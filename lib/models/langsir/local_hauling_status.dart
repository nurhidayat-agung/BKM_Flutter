class LocalHaulingStatus {
  final String? id;
  final String? fieldName;
  final String? fieldValue;
  final String? name;
  final String? code;
  final int? sort;
  final String? description;
  final String? color;
  final String? colorHex;
  final int? isActive;

  LocalHaulingStatus({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
    this.colorHex,
    this.isActive,
  });

  factory LocalHaulingStatus.fromJson(Map<String, dynamic> json) {
    return LocalHaulingStatus(
      id: json['id'],
      fieldName: json['field_name'],
      fieldValue: json['field_value'],
      name: json['name'],
      code: json['code'],
      sort: json['sort'],
      description: json['description'],
      color: json['color'],
      colorHex: json['color_hex'],
      isActive: json['is_active'],
    );
  }
}
