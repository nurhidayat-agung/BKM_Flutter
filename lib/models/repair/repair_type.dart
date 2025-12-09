class RepairType {
  String? id;
  String? fieldName;
  String? fieldValue;
  String? name;
  String? code;
  int? sort;
  String? description;
  String? color;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  RepairType({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory RepairType.fromJson(Map<String, dynamic> json) => RepairType(
    id: json["id"],
    fieldName: json["field_name"],
    fieldValue: json["field_value"],
    name: json["name"],
    code: json["code"],
    sort: json["sort"],
    description: json["description"],
    color: json["color"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}

class UrgencyLevel {
  String? id;
  String? fieldName;
  String? fieldValue;
  String? name;
  String? code;
  int? sort;
  String? description;
  String? color;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  UrgencyLevel({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UrgencyLevel.fromJson(Map<String, dynamic> json) => UrgencyLevel(
    id: json["id"],
    fieldName: json["field_name"],
    fieldValue: json["field_value"],
    name: json["name"],
    code: json["code"],
    sort: json["sort"],
    description: json["description"],
    color: json["color"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}