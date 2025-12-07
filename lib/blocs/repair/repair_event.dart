abstract class RepairEvent {}

class FetchRepairs extends RepairEvent {}

class SubmitRepair extends RepairEvent {
  final String type;
  final String urgency;
  final String lastKm;
  final String description;

  SubmitRepair({
    required this.type,
    required this.urgency,
    required this.lastKm,
    required this.description,
  });
}