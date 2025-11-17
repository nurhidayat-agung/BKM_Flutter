import 'package:hive/hive.dart';

part 'login_local.g.dart';

@HiveType(typeId: 0)
class LoginLocal {
  @HiveField(0)
  final int status;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final String token;

  @HiveField(4)
  final String firebaseToken;

  // ------------ FIELD BARU ( untuk siteid dan driverid) -------------
  @HiveField(5)
  final String? siteId;

  @HiveField(6)
  final String? driverId;

  LoginLocal({
    required this.status,
    required this.message,
    required this.userId,
    required this.token,
    required this.firebaseToken,
    this.siteId,
    this.driverId,
  });
}
