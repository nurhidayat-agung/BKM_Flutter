class LeaveModel {
  final String id;
  final String userId;
  final String leaveTypeId;
  final String startDate;
  final String endDate;
  final String reason;
  final String statusName; // "Tunda", "Disetujui"
  final String statusColorClass; // "bg-soft-warning"
  final String leaveTypeName; // "Cuti Tahunan", "Sakit"
  final String createdAt; // Untuk tanggal pengajuan

  LeaveModel({
    required this.id,
    required this.userId,
    required this.leaveTypeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.statusName,
    required this.statusColorClass,
    required this.leaveTypeName,
    required this.createdAt,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    // Parsing Status (Bisa berupa Objek atau String tergantung endpoint)
    String status = 'Pending';
    String color = 'bg-soft-secondary';

    if (json['status'] != null) {
      if (json['status'] is Map) {
        status = json['status']['name'] ?? 'Pending';
        color = json['status']['color'] ?? 'bg-soft-secondary';
      } else if (json['status'] is String) {
        status = json['status'];
      }
    }

    // Parsing Leave Type
    String typeName = 'Cuti';
    if (json['leave_type'] != null && json['leave_type'] is Map) {
      typeName = json['leave_type']['name'] ?? 'Cuti';
    }

    return LeaveModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      leaveTypeId: json['leave_type_id']?.toString() ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      reason: json['reason'] ?? '-',
      statusName: status,
      statusColorClass: color,
      leaveTypeName: typeName,
      createdAt: json['created_at'] ?? '',
    );
  }
}