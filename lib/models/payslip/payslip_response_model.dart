class PayslipResponseModel {
  final String? status;
  final String? message;
  final PayslipData? data;

  PayslipResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory PayslipResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PayslipResponseModel();
    return PayslipResponseModel(
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      data: json['data'] is Map<String, dynamic>
          ? PayslipData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      if (message != null) 'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class PayslipData {
  final PayrollHeader? payroll;
  final List<IncomeItem> incomes;
  final List<DeductionItem> deductions;

  PayslipData({
    this.payroll,
    this.incomes = const [],
    this.deductions = const [],
  });

  factory PayslipData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PayslipData();
    return PayslipData(
      payroll: json['payroll'] is Map<String, dynamic>
          ? PayrollHeader.fromJson(json['payroll'] as Map<String, dynamic>)
          : null,
      incomes: json['incomes'] is List
          ? (json['incomes'] as List)
              .whereType<Map<String, dynamic>>()
              .map((e) => IncomeItem.fromJson(e))
              .toList()
          : const [],
      deductions: json['deductions'] is List
          ? (json['deductions'] as List)
              .whereType<Map<String, dynamic>>()
              .map((e) => DeductionItem.fromJson(e))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (payroll != null) 'payroll': payroll!.toJson(),
      'incomes': incomes.map((e) => e.toJson()).toList(),
      'deductions': deductions.map((e) => e.toJson()).toList(),
    };
  }
}

class PayrollHeader {
  final String? id;
  final String? driverId;
  final String? siteId;
  final int? month;
  final int? year;
  final String? payrollPeriodAt;
  final int? numberOfTrip;
  final String? baseSalary;
  final String? bonusHonesty;
  final String? totalDeduction;
  final String? grossSalary;
  final String? netSalary;
  final int? isActive;
  final PayrollDriver? driver;

  PayrollHeader({
    this.id,
    this.driverId,
    this.siteId,
    this.month,
    this.year,
    this.payrollPeriodAt,
    this.numberOfTrip,
    this.baseSalary,
    this.bonusHonesty,
    this.totalDeduction,
    this.grossSalary,
    this.netSalary,
    this.isActive,
    this.driver,
  });

  factory PayrollHeader.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PayrollHeader();
    return PayrollHeader(
      id: json['id']?.toString(),
      driverId: json['driver_id']?.toString(),
      siteId: json['site_id']?.toString(),
      month: json['month'] is int
          ? json['month'] as int
          : int.tryParse(json['month']?.toString() ?? ''),
      year: json['year'] is int
          ? json['year'] as int
          : int.tryParse(json['year']?.toString() ?? ''),
      payrollPeriodAt: json['payroll_period_at']?.toString(),
      numberOfTrip: json['number_of_trip'] is int
          ? json['number_of_trip'] as int
          : int.tryParse(json['number_of_trip']?.toString() ?? '0') ?? 0,
      baseSalary: json['base_salary']?.toString(),
      bonusHonesty: json['bonus_honesty']?.toString(),
      totalDeduction: json['total_deduction']?.toString(),
      grossSalary: json['gross_salary']?.toString(),
      netSalary: json['net_salary']?.toString(),
      isActive: json['is_active'] is int
          ? json['is_active'] as int
          : int.tryParse(json['is_active']?.toString() ?? ''),
      driver: json['driver'] is Map<String, dynamic>
          ? PayrollDriver.fromJson(json['driver'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_id': driverId,
      'site_id': siteId,
      'month': month,
      'year': year,
      'payroll_period_at': payrollPeriodAt,
      'number_of_trip': numberOfTrip,
      'base_salary': baseSalary,
      'bonus_honesty': bonusHonesty,
      'total_deduction': totalDeduction,
      'gross_salary': grossSalary,
      'net_salary': netSalary,
      'is_active': isActive,
      if (driver != null) 'driver': driver!.toJson(),
    };
  }
}

class PayrollDriver {
  final String? id;
  final String? siteId;
  final String? userId;
  final dynamic externalEmployeeId;
  final String? name;
  final String? alias;
  final String? code;
  final String? status;
  final String? dateOfBirth;
  final String? placeOfBirth;
  final String? lastEducation;
  final String? nik;
  final String? simNumber;
  final String? simType;
  final String? rekeningNumber;
  final String? phoneNumber;
  final String? activeWorkingDate;
  final String? address;
  final String? nameAlias;

  PayrollDriver({
    this.id,
    this.siteId,
    this.userId,
    this.externalEmployeeId,
    this.name,
    this.alias,
    this.code,
    this.status,
    this.dateOfBirth,
    this.placeOfBirth,
    this.lastEducation,
    this.nik,
    this.simNumber,
    this.simType,
    this.rekeningNumber,
    this.phoneNumber,
    this.activeWorkingDate,
    this.address,
    this.nameAlias,
  });

  factory PayrollDriver.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PayrollDriver();
    return PayrollDriver(
      id: json['id']?.toString(),
      siteId: json['site_id']?.toString(),
      userId: json['user_id']?.toString(),
      externalEmployeeId: json['external_employee_id'],
      name: json['name']?.toString(),
      alias: json['alias']?.toString(),
      code: json['code']?.toString(),
      status: json['status']?.toString(),
      dateOfBirth: json['date_of_birth']?.toString(),
      placeOfBirth: json['place_of_birth']?.toString(),
      lastEducation: json['last_education']?.toString(),
      nik: json['nik']?.toString(),
      simNumber: json['sim_number']?.toString(),
      simType: json['sim_type']?.toString(),
      rekeningNumber: json['rekening_number']?.toString(),
      phoneNumber: json['phone_number']?.toString(),
      activeWorkingDate: json['active_working_date']?.toString(),
      address: json['address']?.toString(),
      nameAlias: json['name_alias']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'site_id': siteId,
      'user_id': userId,
      'external_employee_id': externalEmployeeId,
      'name': name,
      'alias': alias,
      'code': code,
      'status': status,
      'date_of_birth': dateOfBirth,
      'place_of_birth': placeOfBirth,
      'last_education': lastEducation,
      'nik': nik,
      'sim_number': simNumber,
      'sim_type': simType,
      'rekening_number': rekeningNumber,
      'phone_number': phoneNumber,
      'active_working_date': activeWorkingDate,
      'address': address,
      'name_alias': nameAlias,
    };
  }
}

class IncomeItem {
  final dynamic id;
  final String? driverPayrollId;
  final String? type;
  final dynamic qty;
  final String? amount;
  final String? direction;
  final String? referenceId;
  final String? description;
  final int? isActive;

  IncomeItem({
    this.id,
    this.driverPayrollId,
    this.type,
    this.qty,
    this.amount,
    this.direction,
    this.referenceId,
    this.description,
    this.isActive,
  });

  factory IncomeItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return IncomeItem();
    return IncomeItem(
      id: json['id'],
      driverPayrollId: json['driver_payroll_id']?.toString(),
      type: json['type']?.toString(),
      qty: json['qty'],
      amount: json['amount']?.toString(),
      direction: json['direction']?.toString(),
      referenceId: json['reference_id']?.toString(),
      description: json['description']?.toString(),
      isActive: json['is_active'] is int
          ? json['is_active'] as int
          : int.tryParse(json['is_active']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_payroll_id': driverPayrollId,
      'type': type,
      'qty': qty,
      'amount': amount,
      'direction': direction,
      'reference_id': referenceId,
      'description': description,
      'is_active': isActive,
    };
  }
}

class DeductionItem {
  final dynamic id;
  final String? driverPayrollId;
  final String? type;
  final dynamic qty;
  final String? amount;
  final String? direction;
  final String? referenceId;
  final String? description;
  final int? isActive;

  DeductionItem({
    this.id,
    this.driverPayrollId,
    this.type,
    this.qty,
    this.amount,
    this.direction,
    this.referenceId,
    this.description,
    this.isActive,
  });

  factory DeductionItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DeductionItem();
    return DeductionItem(
      id: json['id'],
      driverPayrollId: json['driver_payroll_id']?.toString(),
      type: json['type']?.toString(),
      qty: json['qty'],
      amount: json['amount']?.toString(),
      direction: json['direction']?.toString(),
      referenceId: json['reference_id']?.toString(),
      description: json['description']?.toString(),
      isActive: json['is_active'] is int
          ? json['is_active'] as int
          : int.tryParse(json['is_active']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_payroll_id': driverPayrollId,
      'type': type,
      'qty': qty,
      'amount': amount,
      'direction': direction,
      'reference_id': referenceId,
      'description': description,
      'is_active': isActive,
    };
  }
}
