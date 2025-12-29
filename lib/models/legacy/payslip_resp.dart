class PaySlipResp {
  String? id;
  String? driverId;
  String? salaryTrip;
  String? bonusTrip;
  String? closingDate;
  String? numberOfTrip;
  String? pointTrip;
  String? bonusDecrease;
  String? insentif;
  String? adjustment;
  String? thr;
  String? bpjsKet;
  String? bpjsKes;
  String? pph21;
  String? loanPayment;
  String? debtPayment;
  String? loanPrevMonth;
  String? loanThisMonth;
  String? debtPrevMonth;
  String? debtThisMonth;
  String? savings;
  String? allowView;
  String? updatedBy;
  String? updatedDate;
  String? createdBy;
  String? createdDate;
  String? isactive;
  String? driverName;
  String? gender;
  String? telpNumber;
  String? norek;
  String? activeWorkingDate;
  String? dateOfBirth;
  String? bpjsNumberEmployment;
  String? bpjsNumberHealth;
  String? deptUntilMonth;
  String? remainingDept;
  String? remainingLoan;
  String? deptThisMonth;
  String? deptPrevMonth;
  String? loanUntilMonth;
  String? deptPayment;
  String? prevClosingDate;
  String? saving;

  PaySlipResp(
      {this.id,
        this.driverId,
        this.salaryTrip,
        this.bonusTrip,
        this.closingDate,
        this.numberOfTrip,
        this.pointTrip,
        this.bonusDecrease,
        this.insentif,
        this.adjustment,
        this.thr,
        this.bpjsKet,
        this.bpjsKes,
        this.pph21,
        this.loanPayment,
        this.debtPayment,
        this.loanPrevMonth,
        this.loanThisMonth,
        this.debtPrevMonth,
        this.debtThisMonth,
        this.savings,
        this.allowView,
        this.updatedBy,
        this.updatedDate,
        this.createdBy,
        this.createdDate,
        this.isactive,
        this.driverName,
        this.gender,
        this.telpNumber,
        this.norek,
        this.activeWorkingDate,
        this.dateOfBirth,
        this.bpjsNumberEmployment,
        this.bpjsNumberHealth,
        this.deptUntilMonth,
        this.remainingDept,
        this.remainingLoan,
        this.deptThisMonth,
        this.deptPrevMonth,
        this.loanUntilMonth,
        this.deptPayment,
        this.prevClosingDate,
        this.saving});

  PaySlipResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    salaryTrip = json['salary_trip'];
    bonusTrip = json['bonus_trip'];
    closingDate = json['closing_date'];
    numberOfTrip = json['number_of_trip'];
    pointTrip = json['point_trip'];
    bonusDecrease = json['bonus_decrease'];
    insentif = json['insentif'];
    adjustment = json['adjustment'];
    thr = json['thr'];
    bpjsKet = json['bpjs_ket'];
    bpjsKes = json['bpjs_kes'];
    pph21 = json['pph21'];
    loanPayment = json['loan_payment'];
    debtPayment = json['debt_payment'];
    loanPrevMonth = json['loan_prev_month'];
    loanThisMonth = json['loan_this_month'];
    debtPrevMonth = json['debt_prev_month'];
    debtThisMonth = json['debt_this_month'];
    savings = json['savings'];
    allowView = json['allow_view'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    isactive = json['isactive'];
    driverName = json['driver_name'];
    gender = json['gender'];
    telpNumber = json['telp_number'];
    norek = json['norek'];
    activeWorkingDate = json['active_working_date'];
    dateOfBirth = json['date_of_birth'];
    bpjsNumberEmployment = json['bpjs_number_employment'];
    bpjsNumberHealth = json['bpjs_number_health'];
    deptUntilMonth = json['dept_until_month'];
    remainingDept = json['remaining_dept'];
    remainingLoan = json['remaining_loan'];
    deptThisMonth = json['dept_this_month'];
    deptPrevMonth = json['dept_prev_month'];
    loanUntilMonth = json['loan_until_month'];
    deptPayment = json['dept_payment'];
    prevClosingDate = json['prev_closing_date'];
    saving = json['saving'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_id'] = this.driverId;
    data['salary_trip'] = this.salaryTrip;
    data['bonus_trip'] = this.bonusTrip;
    data['closing_date'] = this.closingDate;
    data['number_of_trip'] = this.numberOfTrip;
    data['point_trip'] = this.pointTrip;
    data['bonus_decrease'] = this.bonusDecrease;
    data['insentif'] = this.insentif;
    data['adjustment'] = this.adjustment;
    data['thr'] = this.thr;
    data['bpjs_ket'] = this.bpjsKet;
    data['bpjs_kes'] = this.bpjsKes;
    data['pph21'] = this.pph21;
    data['loan_payment'] = this.loanPayment;
    data['debt_payment'] = this.debtPayment;
    data['loan_prev_month'] = this.loanPrevMonth;
    data['loan_this_month'] = this.loanThisMonth;
    data['debt_prev_month'] = this.debtPrevMonth;
    data['debt_this_month'] = this.debtThisMonth;
    data['savings'] = this.savings;
    data['allow_view'] = this.allowView;
    data['updated_by'] = this.updatedBy;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['isactive'] = this.isactive;
    data['driver_name'] = this.driverName;
    data['gender'] = this.gender;
    data['telp_number'] = this.telpNumber;
    data['norek'] = this.norek;
    data['active_working_date'] = this.activeWorkingDate;
    data['date_of_birth'] = this.dateOfBirth;
    data['bpjs_number_employment'] = this.bpjsNumberEmployment;
    data['bpjs_number_health'] = this.bpjsNumberHealth;
    data['dept_until_month'] = this.deptUntilMonth;
    data['remaining_dept'] = this.remainingDept;
    data['remaining_loan'] = this.remainingLoan;
    data['dept_this_month'] = this.deptThisMonth;
    data['dept_prev_month'] = this.deptPrevMonth;
    data['loan_until_month'] = this.loanUntilMonth;
    data['dept_payment'] = this.deptPayment;
    data['prev_closing_date'] = this.prevClosingDate;
    data['saving'] = this.saving;
    return data;
  }
}