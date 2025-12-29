import 'package:hive/hive.dart';
import 'package:newbkmmobile/models/legacy/announcement_local.dart';
import 'package:newbkmmobile/models/legacy/vehicle_local.dart';

part 'user_detail_local.g.dart';

@HiveType(typeId: 1)
class UserDetailLocal {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String driverId;

  @HiveField(2)
  final String fullName;

  @HiveField(3)
  final String mobileNumber;

  @HiveField(4)
  final String dOB;

  @HiveField(5)
  final String address;

  @HiveField(6)
  final String bloodType;

  @HiveField(7)
  final String profilImg;

  @HiveField(8)
  final String activeWorkingDate;

  @HiveField(9)
  final String dedication;

  @HiveField(10)
  final String numberOfTrip;

  @HiveField(11)
  final List<AnnouncementLocal> announcement;

  @HiveField(12)

  final VehicleLocal vehicle;

  UserDetailLocal({
    required this.userId,
    required this.driverId,
    required this.fullName,
    required this.mobileNumber,
    required this.dOB,
    required this.address,
    required this.bloodType,
    required this.profilImg,
    required this.activeWorkingDate,
    required this.dedication,
    required this.numberOfTrip,
    required this.announcement,
    required this.vehicle,
  });
}
