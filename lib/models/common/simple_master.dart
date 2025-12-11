class SimpleMaster {
  String? id;
  String? fieldName;
  String? fieldValue;
  String? name;
  String? code;
  int? sort;
  String? description;
  String? color;
  String? colorHex;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  SimpleMaster({
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
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SimpleMaster.fromJson(Map<String, dynamic> json) {
    return SimpleMaster(
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
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'field_name': fieldName,
    'field_value': fieldValue,
    'name': name,
    'code': code,
    'sort': sort,
    'description': description,
    'color': color,
    'color_hex': colorHex,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
