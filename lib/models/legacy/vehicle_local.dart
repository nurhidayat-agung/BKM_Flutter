import 'package:hive/hive.dart';

part 'vehicle_local.g.dart';

@HiveType(typeId: 3)
class VehicleLocal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String vehicleNumber;

  @HiveField(2)
  final String isAvailable;

  @HiveField(3)
  final String repairStatus;

  @HiveField(4)
  final String capacity;

  VehicleLocal({
    required this.id,
    required this.vehicleNumber,
    required this.isAvailable,
    required this.repairStatus,
    required this.capacity,
  });
  // factory VehicleLocal.empty() {
  //   return VehicleLocal(
  //     id: '',
  //     vehicleNumber: '',
  //     isAvailable: '0',
  //     repairStatus: 'Normal Ya',
  //     capacity: '0',
  //   );
  // }
}