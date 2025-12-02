class DriverHistory {
  String? id;
  String? siteId;
  String? userId;
  String? name;
  String? alias;
  String? code;
  String? status;
  String? ein;
  String? dateOfBirth;
  String? placeOfBirth;
  String? lastEducation;
  String? gender;
  String? nik;
  String? simNumber;
  String? simType;
  String? bpjsNumber;
  String? kkNumber;
  String? rekeningNumber;
  String? phoneNumber;
  int? isBackupDriver;
  String? activeWorkingDate;
  String? address;
  String? bloodType;
  String? statusDesc;
  String? description;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  DriverHistory();

  factory DriverHistory.fromJson(Map<String, dynamic> json) => DriverHistory()
    ..id = json['id']
    ..siteId = json['site_id']
    ..userId = json['user_id']
    ..name = json['name']
    ..alias = json['alias']
    ..code = json['code']
    ..status = json['status']
    ..ein = json['ein']
    ..dateOfBirth = json['date_of_birth']
    ..placeOfBirth = json['place_of_birth']
    ..lastEducation = json['last_education']
    ..gender = json['gender']
    ..nik = json['nik']
    ..simNumber = json['sim_number']
    ..simType = json['sim_type']
    ..bpjsNumber = json['bpjs_number']
    ..kkNumber = json['kk_number']
    ..rekeningNumber = json['rekening_number']
    ..phoneNumber = json['phone_number']
    ..isBackupDriver = json['is_backup_driver']
    ..activeWorkingDate = json['active_working_date']
    ..address = json['address']
    ..bloodType = json['blood_type']
    ..statusDesc = json['status_desc']
    ..description = json['description']
    ..isActive = json['is_active']
    ..createdBy = json['created_by']
    ..updatedBy = json['updated_by']
    ..deletedBy = json['deleted_by']
    ..deletedAt = json['deleted_at']
    ..createdAt = json['created_at']
    ..updatedAt = json['updated_at'];


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "site_id": siteId,
      "user_id": userId,
      "name": name,
      "alias": alias,
      "code": code,
      "status": status,
      "ein": ein,
      "date_of_birth": dateOfBirth,
      "place_of_birth": placeOfBirth,
      "last_education": lastEducation,
      "gender": gender,
      "nik": nik,
      "sim_number": simNumber,
      "sim_type": simType,
      "bpjs_number": bpjsNumber,
      "kk_number": kkNumber,
      "rekening_number": rekeningNumber,
      "phone_number": phoneNumber,
      "is_backup_driver": isBackupDriver,
      "active_working_date": activeWorkingDate,
      "address": address,
      "blood_type": bloodType,
      "status_desc": statusDesc,
      "description": description,
      "is_active": isActive,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "deleted_by": deletedBy,
      "deleted_at": deletedAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }

}
