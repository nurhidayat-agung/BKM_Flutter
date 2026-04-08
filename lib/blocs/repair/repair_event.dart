import 'package:newbkmmobile/models/common/hive/hive_simple_master.dart';

abstract class RepairEvent {}

class FetchRepairs extends RepairEvent {}
class RepairLoadingEvent extends RepairEvent {}

class SubmitRepair extends RepairEvent {
  final String? id;
  final String status;
  final String type;
  final String urgency;
  final String lastKm;
  final String description;
  final List<String> listRepair;
  final List<HiveSimpleMaster> listUrgencyLevel;
  final List<HiveSimpleMaster> listRepairType;
  final List<HiveSimpleMaster> maintenanceType;
  final String workshopType;
  final List<HiveSimpleMaster> listWorkshopType;



  SubmitRepair({
    required this.id,
    required this.status,
    required this.type,
    required this.listRepair,
    required this.urgency,
    required this.lastKm,
    required this.description,
    required this.listUrgencyLevel,
    required this.listRepairType,
    required this.maintenanceType,
    required this.workshopType,
    required this.listWorkshopType,
  });
}
