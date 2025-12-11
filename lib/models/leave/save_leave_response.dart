class SaveLeaveResponse {
  String? status;
  String? message;
  SaveLeaveData? data;

  SaveLeaveResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SaveLeaveResponse.fromJson(Map<String, dynamic> json) {
    return SaveLeaveResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? SaveLeaveData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class SaveLeaveData {
  String? userId;
  String? leaveTypeId;
  String? startDate;
  String? endDate;
  String? reason;
  String? status;
  String? id;
  String? createdBy;
  String? updatedBy;
  String? updatedAt;
  String? createdAt;

  SaveLeaveData({
    this.userId,
    this.leaveTypeId,
    this.startDate,
    this.endDate,
    this.reason,
    this.status,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.updatedAt,
    this.createdAt,
  });

  factory SaveLeaveData.fromJson(Map<String, dynamic> json) {
    return SaveLeaveData(
      userId: json['user_id'] as String?,
      leaveTypeId: json['leave_type_id'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      id: json['id'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'leave_type_id': leaveTypeId,
      'start_date': startDate,
      'end_date': endDate,
      'reason': reason,
      'status': status,
      'id': id,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
