import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/R/HiveTypeId.dart';
import 'package:newbkmmobile/models/login/login_response.dart';

part 'UserSession.g.dart';

@HiveType(typeId: HiveTypeId.userSession)
class UserSession extends HiveObject {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? roleId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? roleName;

  @HiveField(4)
  String? token;

  @HiveField(5)
  String? siteId;

  // Driver & Vehicle
  @HiveField(6)
  String? driverId;

  @HiveField(7)
  String? vehicleId;

  @HiveField(8)
  String? policeNumber;

  // Wallet
  @HiveField(9)
  String? walletId;

  @HiveField(10)
  String? balance;

  @HiveField(11)
  String? savings;

  // Manual flag untuk bloc / state
  @HiveField(12)
  int status = 0;

  @HiveField(13)
  String? userLogin;

  @HiveField(14)
  String? password;

  @HiveField(15)
  String? saving;

  @HiveField(16)
  String? heldAmmount;

  UserSession({
    this.userId,
    this.roleId,
    this.name,
    this.roleName,
    this.token,
    this.siteId,
    this.driverId,
    this.vehicleId,
    this.policeNumber,
    this.walletId,
    this.balance,
    this.savings,
    this.status = 0,
    this.userLogin,
    this.password,
    this.saving,
    this.heldAmmount,
  });

  /// Factory untuk buat UserSession dari LoginResponse
  factory UserSession.fromLoginResponse(LoginResponse response) {
    final user = response.data?.user;
    final Role? role;
    if (user?.roles != null && user!.roles!.isNotEmpty) {
      role = user.roles?.first;
    } else {
      role = null;
    }
    final driver = user?.driver;
    final vehicle = driver?.vehicle;
    final wallet = driver?.wallet;

    return UserSession(
      userId: user?.id,
      roleId: user?.roleId,
      name: user?.name,
      roleName: role?.name,
      token: response.data?.token,
      siteId: driver?.siteId,
      driverId: driver?.id,
      vehicleId: vehicle?.id,
      policeNumber: vehicle?.policeNumber,
      walletId: wallet?.id,
      balance: wallet?.balance,
      savings: wallet?.savings,
      heldAmmount: wallet?.heldAmount,
    );
  }

  /// Factory dari JSON Map
  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      userId: json['userId'] as String?,
      roleId: json['roleId'] as String?,
      name: json['name'] as String?,
      roleName: json['roleName'] as String?,
      token: json['token'] as String?,
      siteId: json['siteId'] as String?,
      driverId: json['driverId'] as String?,
      vehicleId: json['vehicleId'] as String?,
      policeNumber: json['policeNumber'] as String?,
      walletId: json['walletId'] as String?,
      balance: json['balance'] as String?,
      savings: json['savings'] as String?,
      status: json['status'] as int? ?? 0,
      heldAmmount: json['held_amount'] as String?
    );
  }

  /// Convert ke JSON Map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'roleId': roleId,
      'name': name,
      'roleName': roleName,
      'token': token,
      'siteId': siteId,
      'driverId': driverId,
      'vehicleId': vehicleId,
      'policeNumber': policeNumber,
      'walletId': walletId,
      'balance': balance,
      'savings': savings,
      'status': status,
    };
  }
}
