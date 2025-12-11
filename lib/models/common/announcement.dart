class Announcement {
  String? id;
  int? sort;
  String? startDate;
  String? endDate;
  String? message;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Announcement({
    this.id,
    this.sort,
    this.startDate,
    this.endDate,
    this.message,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      sort: json['sort'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      message: json['message'],
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
    'sort': sort,
    'start_date': startDate,
    'end_date': endDate,
    'message': message,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
