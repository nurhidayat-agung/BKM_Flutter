import 'dart:convert';

class LoginResponse {
  final String status;
  final LoginData data;
  final String message;

  LoginResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    data: LoginData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class LoginData {
  final User user;
  final String tokenType;
  final String token;
  final int expiresIn;

  LoginData({
    required this.user,
    required this.tokenType,
    required this.token,
    required this.expiresIn,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    user: User.fromJson(json["user"]),
    tokenType: json["token_type"],
    token: json["token"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token_type": tokenType,
    "token": token,
    "expires_in": expiresIn,
  };
}

class User {
  final String id;
  final String roleId;
  final String name;
  final String phone;
  final String? email;
  final String? emailVerifiedAt;
  final String password;
  final String platform;
  final String? firebaseToken;
  final String? lastLoginAt;
  final String createdAt;
  final String updatedAt;
  final List<Role> roles;
  final Driver driver;

  User({
    required this.id,
    required this.roleId,
    required this.name,
    required this.phone,
    this.email,
    this.emailVerifiedAt,
    required this.password,
    required this.platform,
    this.firebaseToken,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
    required this.driver,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    roleId: json["role_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    platform: json["platform"],
    firebaseToken: json["firebase_token"],
    lastLoginAt: json["last_login_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    driver: Driver.fromJson(json["driver"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role_id": roleId,
    "name": name,
    "phone": phone,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "platform": platform,
    "firebase_token": firebaseToken,
    "last_login_at": lastLoginAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "driver": driver.toJson(),
  };
}

class Role {
  final String id;
  final String name;
  final String description;
  final int isActive;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "is_active": isActive,
  };
}

// Driver class
class Driver {
  final String id;
  final String siteId;
  final String userId;
  final String name;
  final String code;
  final String status;
  final String placeOfBirth;
  final String simNumber;
  final String simType;
  final String rekeningNumber;
  final String phoneNumber;
  final String address;
  final int isActive;
  final Site site;
  final Vehicle vehicle;
  final Wallet wallet;
  final List<Deduction> deductions;
  final DriverStatus driverStatus;

  Driver({
    required this.id,
    required this.siteId,
    required this.userId,
    required this.name,
    required this.code,
    required this.status,
    required this.placeOfBirth,
    required this.simNumber,
    required this.simType,
    required this.rekeningNumber,
    required this.phoneNumber,
    required this.address,
    required this.isActive,
    required this.site,
    required this.vehicle,
    required this.wallet,
    required this.deductions,
    required this.driverStatus,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    siteId: json["site_id"],
    userId: json["user_id"],
    name: json["name"],
    code: json["code"],
    status: json["status"],
    placeOfBirth: json["place_of_birth"],
    simNumber: json["sim_number"],
    simType: json["sim_type"],
    rekeningNumber: json["rekening_number"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    isActive: json["is_active"],
    site: Site.fromJson(json["site"]),
    vehicle: Vehicle.fromJson(json["vehicle"]),
    wallet: Wallet.fromJson(json["wallet"]),
    deductions: List<Deduction>.from(
        json["deductions"].map((x) => Deduction.fromJson(x))),
    driverStatus: DriverStatus.fromJson(json["driver_status"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "site_id": siteId,
    "user_id": userId,
    "name": name,
    "code": code,
    "status": status,
    "place_of_birth": placeOfBirth,
    "sim_number": simNumber,
    "sim_type": simType,
    "rekening_number": rekeningNumber,
    "phone_number": phoneNumber,
    "address": address,
    "is_active": isActive,
    "site": site.toJson(),
    "vehicle": vehicle.toJson(),
    "wallet": wallet.toJson(),
    "deductions": List<dynamic>.from(deductions.map((x) => x.toJson())),
    "driver_status": driverStatus.toJson(),
  };
}

// Site class
class Site {
  final String id;
  final String name;
  final String alias;
  final String code;
  final int sort;
  final int isActive;

  Site({
    required this.id,
    required this.name,
    required this.alias,
    required this.code,
    required this.sort,
    required this.isActive,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    id: json["id"],
    name: json["name"],
    alias: json["alias"],
    code: json["code"],
    sort: json["sort"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alias": alias,
    "code": code,
    "sort": sort,
    "is_active": isActive,
  };
}

// Vehicle class
class Vehicle {
  final String id;
  final String siteId;
  final String typeVehicleId;
  final String fuelTypeId;
  final String pic;
  final String status;
  final String policeNumber;
  final String stnkNumber;
  final int capacity;
  final int productionYear;
  final int isActive;

  Vehicle({
    required this.id,
    required this.siteId,
    required this.typeVehicleId,
    required this.fuelTypeId,
    required this.pic,
    required this.status,
    required this.policeNumber,
    required this.stnkNumber,
    required this.capacity,
    required this.productionYear,
    required this.isActive,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"],
    siteId: json["site_id"],
    typeVehicleId: json["type_vehicle_id"],
    fuelTypeId: json["fuel_type_id"],
    pic: json["pic"],
    status: json["status"],
    policeNumber: json["police_number"],
    stnkNumber: json["stnk_number"],
    capacity: json["capacity"],
    productionYear: json["production_year"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "site_id": siteId,
    "type_vehicle_id": typeVehicleId,
    "fuel_type_id": fuelTypeId,
    "pic": pic,
    "status": status,
    "police_number": policeNumber,
    "stnk_number": stnkNumber,
    "capacity": capacity,
    "production_year": productionYear,
    "is_active": isActive,
  };
}

// Wallet class
class Wallet {
  final String id;
  final String driverId;
  final String balance;
  final String savings;
  final String heldAmount;
  final int isActive;

  Wallet({
    required this.id,
    required this.driverId,
    required this.balance,
    required this.savings,
    required this.heldAmount,
    required this.isActive,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    driverId: json["driver_id"],
    balance: json["balance"],
    savings: json["savings"],
    heldAmount: json["held_amount"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "balance": balance,
    "savings": savings,
    "held_amount": heldAmount,
    "is_active": isActive,
  };
}

// Deduction class
class Deduction {
  final String id;
  final String driverId;
  final String deductionTypeId;
  final String amount;
  final String? remainingAmount;
  final String? installmentPerMonth;
  final int? totalInstallments;
  final int? remainingInstallments;
  final int isPaid;
  final int isActive;

  Deduction({
    required this.id,
    required this.driverId,
    required this.deductionTypeId,
    required this.amount,
    this.remainingAmount,
    this.installmentPerMonth,
    this.totalInstallments,
    this.remainingInstallments,
    required this.isPaid,
    required this.isActive,
  });

  factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
    id: json["id"],
    driverId: json["driver_id"],
    deductionTypeId: json["deduction_type_id"],
    amount: json["amount"],
    remainingAmount: json["remaining_amount"],
    installmentPerMonth: json["installment_per_month"],
    totalInstallments: json["total_installments"],
    remainingInstallments: json["remaining_installments"],
    isPaid: json["is_paid"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "deduction_type_id": deductionTypeId,
    "amount": amount,
    "remaining_amount": remainingAmount,
    "installment_per_month": installmentPerMonth,
    "total_installments": totalInstallments,
    "remaining_installments": remainingInstallments,
    "is_paid": isPaid,
    "is_active": isActive,
  };
}

// DriverStatus class
class DriverStatus {
  final String id;
  final String fieldName;
  final String fieldValue;
  final String name;
  final String code;
  final int sort;
  final int isActive;

  DriverStatus({
    required this.id,
    required this.fieldName,
    required this.fieldValue,
    required this.name,
    required this.code,
    required this.sort,
    required this.isActive,
  });

  factory DriverStatus.fromJson(Map<String, dynamic> json) => DriverStatus(
    id: json["id"],
    fieldName: json["field_name"],
    fieldValue: json["field_value"],
    name: json["name"],
    code: json["code"],
    sort: json["sort"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "field_name": fieldName,
    "field_value": fieldValue,
    "name": name,
    "code": code,
    "sort": sort,
    "is_active": isActive,
  };
}
