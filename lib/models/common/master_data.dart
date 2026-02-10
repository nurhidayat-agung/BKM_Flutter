import 'package:newbkmmobile/models/common/simple_master.dart';

class MasterData {
  List<SimpleMaster>? repairTypes;
  List<SimpleMaster>? leaveTypes;
  List<SimpleMaster>? urgencyLevels;
  List<SimpleMaster>? maintenanceTypes; // ⬅️ tambahan

  MasterData({
    this.repairTypes,
    this.leaveTypes,
    this.urgencyLevels,
    this.maintenanceTypes,
  });

  factory MasterData.fromJson(Map<String, dynamic> json) {
    return MasterData(
      repairTypes: json['repair_types'] != null
          ? (json['repair_types'] as List)
          .map((e) => SimpleMaster.fromJson(e))
          .toList()
          : null,
      leaveTypes: json['leave_types'] != null
          ? (json['leave_types'] as List)
          .map((e) => SimpleMaster.fromJson(e))
          .toList()
          : null,
      urgencyLevels: json['urgency_levels'] != null
          ? (json['urgency_levels'] as List)
          .map((e) => SimpleMaster.fromJson(e))
          .toList()
          : null,
      maintenanceTypes: json['maintenance_types'] != null
          ? (json['maintenance_types'] as List)
          .map((e) => SimpleMaster.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'repair_types': repairTypes?.map((e) => e.toJson()).toList(),
    'leave_types': leaveTypes?.map((e) => e.toJson()).toList(),
    'urgency_levels': urgencyLevels?.map((e) => e.toJson()).toList(),
    'maintenance_types':
    maintenanceTypes?.map((e) => e.toJson()).toList(),
  };
}
