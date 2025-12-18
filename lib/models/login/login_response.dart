// ------------------ Login Response ------------------

class LoginResponse {
  final String? status;
  final LoginData? data;
  final String? message;

  LoginResponse({
    this.status,
    this.data,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: _safeString(json['status']),
      data: _safeMap(json['data']) != null
          ? LoginData.fromJson(json['data'])
          : null,
      message: _safeString(json['message']),
    );
  }
}

// ------------------ Login Data ------------------

class LoginData {
  final User? user;
  final String? tokenType;
  final String? token;
  final int? expiresIn;

  LoginData({
    this.user,
    this.tokenType,
    this.token,
    this.expiresIn,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: _safeMap(json['user']) != null ? User.fromJson(json['user']) : null,
      tokenType: _safeString(json['token_type']),
      token: _safeString(json['token']),
      expiresIn: _safeInt(json['expires_in']),
    );
  }
}

// ------------------ User ------------------

class User {
  final String? id;
  final String? roleId;
  final String? name;
  final String? phone;
  final String? firebaseToken;
  final List<Role>? roles;
  final Driver? driver;
  final Wallet? wallet; // ✅ TAMBAH

  User({
    this.id,
    this.roleId,
    this.name,
    this.phone,
    this.firebaseToken,
    this.roles,
    this.driver,
    this.wallet, // ✅ TAMBAH
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: _safeString(json['id']),
      roleId: _safeString(json['role_id']),
      name: _safeString(json['name']),
      phone: _safeString(json['phone']),
      firebaseToken: _safeString(json['firebase_token']),
      roles: _safeList(json['roles'])
          ?.map((e) => Role.fromJson(e))
          .toList(),
      driver: _safeMap(json['driver']) != null
          ? Driver.fromJson(json['driver'])
          : null,
      wallet: _safeMap(json['wallet']) != null
          ? Wallet.fromJson(json['wallet'])
          : null, // ✅ TAMBAH
    );
  }
}


//

class Wallet {
  final String? id;
  final String? driverId;
  final String? balance;
  final String? savings;
  final String? heldAmount;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  Wallet({
    this.id,
    this.driverId,
    this.balance,
    this.savings,
    this.heldAmount,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: _safeString(json['id']),
      driverId: _safeString(json['driver_id']),
      balance: _safeString(json['balance']),
      savings: _safeString(json['savings']),
      heldAmount: _safeString(json['held_amount']),
      isActive: json['is_active'] is int ? json['is_active'] : null,
      createdBy: _safeString(json['created_by']),
      updatedBy: _safeString(json['updated_by']),
      deletedBy: _safeString(json['deleted_by']),
      deletedAt: _safeString(json['deleted_at']),
      createdAt: _safeString(json['created_at']),
      updatedAt: _safeString(json['updated_at']),
    );
  }
}



// ------------------ Role ------------------

class Role {
  final String? id;
  final String? name;
  final String? description;

  Role({this.id, this.name, this.description});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: _safeString(json['id']),
      name: _safeString(json['name']),
      description: _safeString(json['description']),
    );
  }
}

// ------------------ Driver ------------------

class Driver {
  final String? id;
  final String? siteId;
  final String? userId;
  final String? name;
  final String? alias;
  final String? code;
  final String? status;
  final String? ein;
  final String? dateOfBirth;
  final String? placeOfBirth;
  final String? lastEducation;
  final String? gender;
  final String? nik;
  final String? simNumber;
  final String? simType;
  final String? bpjsNumber;
  final String? kkNumber;
  final String? rekeningNumber;
  final String? phoneNumber;
  final int? isBackupDriver;
  final String? activeWorkingDate;
  final String? address;
  final String? bloodType;
  final String? statusDesc;
  final String? description;

  final Site? site;
  final Vehicle? vehicle;
  final Wallet? wallet;
  final List<Deduction>? deductions;
  final DriverStatus? driverStatus;

  Driver({
    this.id,
    this.siteId,
    this.userId,
    this.name,
    this.alias,
    this.code,
    this.status,
    this.ein,
    this.dateOfBirth,
    this.placeOfBirth,
    this.lastEducation,
    this.gender,
    this.nik,
    this.simNumber,
    this.simType,
    this.bpjsNumber,
    this.kkNumber,
    this.rekeningNumber,
    this.phoneNumber,
    this.isBackupDriver,
    this.activeWorkingDate,
    this.address,
    this.bloodType,
    this.statusDesc,
    this.description,
    this.site,
    this.vehicle,
    this.wallet,
    this.deductions,
    this.driverStatus,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: _safeString(json['id']),
      siteId: _safeString(json['site_id']),
      userId: _safeString(json['user_id']),
      name: _safeString(json['name']),
      alias: _safeString(json['alias']),
      code: _safeString(json['code']),
      status: _safeString(json['status']),
      ein: _safeString(json['ein']),
      dateOfBirth: _safeString(json['date_of_birth']),
      placeOfBirth: _safeString(json['place_of_birth']),
      lastEducation: _safeString(json['last_education']),
      gender: _safeString(json['gender']),
      nik: _safeString(json['nik']),
      simNumber: _safeString(json['sim_number']),
      simType: _safeString(json['sim_type']),
      bpjsNumber: _safeString(json['bpjs_number']),
      kkNumber: _safeString(json['kk_number']),
      rekeningNumber: _safeString(json['rekening_number']),
      phoneNumber: _safeString(json['phone_number']),
      isBackupDriver: _safeInt(json['is_backup_driver']),
      activeWorkingDate: _safeString(json['active_working_date']),
      address: _safeString(json['address']),
      bloodType: _safeString(json['blood_type']),
      statusDesc: _safeString(json['status_desc']),
      description: _safeString(json['description']),
      site: _safeMap(json['site']) != null ? Site.fromJson(json['site']) : null,
      vehicle: _safeMap(json['vehicle']) != null
          ? Vehicle.fromJson(json['vehicle'])
          : null,
      wallet: _safeMap(json['wallet']) != null
          ? Wallet.fromJson(json['wallet'])
          : null,
      deductions: _safeList(json['deductions'])
          ?.map((e) => Deduction.fromJson(e))
          .toList(),
      driverStatus: _safeMap(json['driver_status']) != null
          ? DriverStatus.fromJson(json['driver_status'])
          : null,
    );
  }
}

// ------------------ Site ------------------

class Site {
  final String? id;
  final String? name;
  final String? alias;
  final String? code;
  final int? sort;
  final String? description;

  Site({
    this.id,
    this.name,
    this.alias,
    this.code,
    this.sort,
    this.description,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      id: _safeString(json['id']),
      name: _safeString(json['name']),
      alias: _safeString(json['alias']),
      code: _safeString(json['code']),
      sort: _safeInt(json['sort']),
      description: _safeString(json['description']),
    );
  }
}

// ------------------ Vehicle ------------------

class Vehicle {
  final String? id;
  final String? siteId;
  final String? typeVehicleId;
  final String? fuelTypeId;
  final String? pic;
  final String? status;
  final String? policeNumber;
  final String? stnkNumber;
  final String? stnkExpiration;
  final String? taxExpiration;
  final String? kirExpiration;
  final String? chassisNumber;
  final String? machineNumber;
  final int? capacity;
  final String? estimatedLoad;
  final int? productionYear;
  final String? terminal;
  final String? description;

  Vehicle({
    this.id,
    this.siteId,
    this.typeVehicleId,
    this.fuelTypeId,
    this.pic,
    this.status,
    this.policeNumber,
    this.stnkNumber,
    this.stnkExpiration,
    this.taxExpiration,
    this.kirExpiration,
    this.chassisNumber,
    this.machineNumber,
    this.capacity,
    this.estimatedLoad,
    this.productionYear,
    this.terminal,
    this.description,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: _safeString(json['id']),
      siteId: _safeString(json['site_id']),
      typeVehicleId: _safeString(json['type_vehicle_id']),
      fuelTypeId: _safeString(json['fuel_type_id']),
      pic: _safeString(json['pic']),
      status: _safeString(json['status']),
      policeNumber: _safeString(json['police_number']),
      stnkNumber: _safeString(json['stnk_number']),
      stnkExpiration: _safeString(json['stnk_expiration']),
      taxExpiration: _safeString(json['tax_expiration']),
      kirExpiration: _safeString(json['kir_expiration']),
      chassisNumber: _safeString(json['chassis_number']),
      machineNumber: _safeString(json['machine_number']),
      capacity: _safeInt(json['capacity']),
      estimatedLoad: _safeString(json['estimated_load']),
      productionYear: _safeInt(json['production_year']),
      terminal: _safeString(json['terminal']),
      description: _safeString(json['description']),
    );
  }
}

// ------------------ Deduction ------------------

class Deduction {
  final String? id;
  final String? driverId;
  final String? deductionTypeId;
  final String? amount;
  final String? remainingAmount;
  final String? installmentPerMonth;
  final int? totalInstallments;
  final dynamic remainingInstallments;
  final int? isPaid;
  final String? note;
  final String? effectiveDate;

  Deduction({
    this.id,
    this.driverId,
    this.deductionTypeId,
    this.amount,
    this.remainingAmount,
    this.installmentPerMonth,
    this.totalInstallments,
    this.remainingInstallments,
    this.isPaid,
    this.note,
    this.effectiveDate,
  });

  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
      id: _safeString(json['id']),
      driverId: _safeString(json['driver_id']),
      deductionTypeId: _safeString(json['deduction_type_id']),
      amount: _safeString(json['amount']),
      remainingAmount: _safeString(json['remaining_amount']),
      installmentPerMonth: _safeString(json['installment_per_month']),
      totalInstallments: _safeInt(json['total_installments']),
      remainingInstallments: json['remaining_installments'],
      isPaid: _safeInt(json['is_paid']),
      note: _safeString(json['note']),
      effectiveDate: _safeString(json['effective_date']),
    );
  }
}

// ------------------ Driver Status ------------------

class DriverStatus {
  final String? id;
  final String? fieldName;
  final String? fieldValue;
  final String? name;
  final String? code;
  final int? sort;
  final String? description;
  final String? color;
  final String? colorHex;

  DriverStatus({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
    this.colorHex,
  });

  factory DriverStatus.fromJson(Map<String, dynamic> json) {
    return DriverStatus(
      id: _safeString(json['id']),
      fieldName: _safeString(json['field_name']),
      fieldValue: _safeString(json['field_value']),
      name: _safeString(json['name']),
      code: _safeString(json['code']),
      sort: _safeInt(json['sort']),
      description: _safeString(json['description']),
      color: _safeString(json['color']),
      colorHex: _safeString(json['color_hex']),
    );
  }
}

// --------------------------------------------------------------------
// SAFE CAST HELPERS (ANTI ERROR / TIDAK BIKIN CRASH)
// --------------------------------------------------------------------

String? _safeString(dynamic value) {
  try {
    if (value == null) return null;
    return value.toString();
  } catch (_) {
    return null;
  }
}

int? _safeInt(dynamic value) {
  try {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  } catch (_) {
    return null;
  }
}

Map<String, dynamic>? _safeMap(dynamic value) {
  try {
    if (value is Map<String, dynamic>) return value;
    return null;
  } catch (_) {
    return null;
  }
}

List<dynamic>? _safeList(dynamic value) {
  try {
    if (value is List) return value;
    return null;
  } catch (_) {
    return null;
  }
}
