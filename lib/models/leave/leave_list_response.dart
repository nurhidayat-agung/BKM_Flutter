class LeaveListResponse {
  String? status;
  List<LeaveData>? data;

  LeaveListResponse({this.status, this.data});

  factory LeaveListResponse.fromJson(Map<String, dynamic> json) {
    return LeaveListResponse(
      status: json['status'],
      data: json['data'] != null
          ? List<LeaveData>.from(
        json['data'].map((x) => LeaveData.fromJson(x)),
      )
          : null,
    );
  }
}

class LeaveData {
  String? id;
  String? userId;
  String? leaveTypeId;
  String? startDate;
  String? endDate;
  String? reason;
  LeaveStatus? status;
  String? approvedBy;
  String? approvedAt;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  LeaveUser? user;
  LeaveType? leaveType;

  LeaveData({
    this.id,
    this.userId,
    this.leaveTypeId,
    this.startDate,
    this.endDate,
    this.reason,
    this.status,
    this.approvedBy,
    this.approvedAt,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.leaveType,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      id: json['id'],
      userId: json['user_id'],
      leaveTypeId: json['leave_type_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      reason: json['reason'],
      status:
      json['status'] != null ? LeaveStatus.fromJson(json['status']) : null,
      approvedBy: json['approved_by'],
      approvedAt: json['approved_at'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? LeaveUser.fromJson(json['user']) : null,
      leaveType:
      json['leave_type'] != null ? LeaveType.fromJson(json['leave_type']) : null,
    );
  }
}

class LeaveStatus {
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

  LeaveStatus({
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

  factory LeaveStatus.fromJson(Map<String, dynamic> json) {
    return LeaveStatus(
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
}

class LeaveUser {
  String? id;
  String? roleId;
  String? name;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? platform;
  String? firebaseToken;
  String? lastLoginAt;
  String? createdAt;
  String? updatedAt;

  LeaveUser({
    this.id,
    this.roleId,
    this.name,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.platform,
    this.firebaseToken,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveUser.fromJson(Map<String, dynamic> json) {
    return LeaveUser(
      id: json['id'],
      roleId: json['role_id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      password: json['password'],
      platform: json['platform'],
      firebaseToken: json['firebase_token'],
      lastLoginAt: json['last_login_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class LeaveType {
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

  LeaveType({
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

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(
      id: json['id'],
      fieldName: json['field_name'],
      fieldValue: json['field_value'],
      name: json['name'],
      code: json['code'],
      sort: json['sort'],
      description: json['description'],
      color: json['color'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
